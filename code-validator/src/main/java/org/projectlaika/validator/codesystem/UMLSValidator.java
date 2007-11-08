package org.projectlaika.validator.codesystem;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

/**
 * Class used to perfome code validation based off of a UMLS database.
 * 
 * @author bobd
 * 
 */
public class UMLSValidator implements Validator {

	private javax.sql.DataSource dataSource;
	private Map<String, String> nameToIsoMap = new HashMap<String, String>();
	private Map<String, String> isoToNameMap = new HashMap<String, String>();

	private String validateCodeStatement = "Select count(*) as count from MRCONSO "
			+ "where SAB = ? and CODE = ?";
	private String validateCodeAndNameStatement = "Select count(*) as count from MRCONSO "
			+ "where SAB = ? and CODE = ? and STR=?";
	private String validaterelStatement = "Select count(*) as count from MRREL "
			+ "where SAB=? and CUI1 = (Select CUI from MRCONSO where SAB = ? and "
			+ "CODE=?) and CUI2 = (Select CUI from MRCONSO where SAB = ? and CODE=?)"
			+ " and RELA = ?";

	/**
	 * 
	 * @throws Exception
	 */
	public UMLSValidator() {

	}

	/**
	 * Create a validator using the iso/code system mapping file.
	 * 
	 * @param fileName
	 * @throws Exception
	 *             if the file cannot be loaded
	 */
	public UMLSValidator(String fileName) throws Exception {
		loadIosMap(fileName, true);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.projectlaika.validator.codesystem.Validator#validateCode(java.lang.String,
	 *      java.lang.String, boolean)
	 */
	public boolean validateCode(String isoSystem, String code,
			boolean includeInActive) {
		int count = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		try {
			System.out.println("[" + getSystemName(isoSystem) + "] " + code);
			conn = dataSource.getConnection();
			stmt = conn.prepareStatement(validateCodeStatement);
			stmt.setString(1, getSystemName(isoSystem));
			stmt.setString(2, code);
			rset = stmt.executeQuery();

			if (rset.next()) {
				count = rset.getInt("count");
				System.out.println(" count == " + count);
			}
			rset.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnectionAndStatement(conn, stmt, rset);
		}
		return count > 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.projectlaika.validator.codesystem.Validator#validateCode(java.lang.String,
	 *      java.lang.String, java.lang.String, boolean)
	 */
	public boolean validateCode(String isoSystem, String code, String codename,
			boolean includeInActive) {
		int count = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		try {

			conn = dataSource.getConnection();
			stmt = conn.prepareStatement(validateCodeStatement);
			stmt.setString(1, getSystemName(isoSystem));
			stmt.setString(2, code);
			stmt.setString(3, codename);
			rset = stmt.executeQuery();

			if (rset.next()) {
				count = rset.getInt("count");
				System.out.println(" count == " + count);
			}
			rset.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnectionAndStatement(conn, stmt, rset);
		}
		return count > 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.projectlaika.validator.codesystem.Validator#validateRelationship(java.lang.String,
	 *      java.lang.String, java.lang.String, java.lang.String, boolean)
	 */
	public boolean validateRelationship(String isoSystem, String code1,
			String code2, String relationship, boolean useInactive) {
		int count = 0;
		String iso = getSystemName(isoSystem);
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rset = null;
		try {
			conn = dataSource.getConnection();
			stmt = conn.prepareStatement(validaterelStatement);
			stmt.setString(1, iso);
			stmt.setString(2, iso);
			stmt.setString(3, code1);
			stmt.setString(4, iso);
			stmt.setString(5, code2);
			stmt.setString(6, relationship);
			rset = stmt.executeQuery();
			if (rset.next()) {
				count = rset.getInt("count");
			}
			rset.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeConnectionAndStatement(conn, stmt, rset);
		}
		return count > 0;
	}

	/**
	 * Get the datasource used to connect to the UMLS DB
	 * 
	 * @return
	 */
	public javax.sql.DataSource getDataSource() {
		return dataSource;
	}

	/**
	 * Set the data source used to connect to the umls db
	 * 
	 * @param ds
	 */
	public void setDataSource(javax.sql.DataSource ds) {
		this.dataSource = ds;
	}

	/**
	 * Get the iso / code system name mapping
	 * 
	 * @return
	 */
	public Map getNameToIsoMap() {
		return nameToIsoMap;
	}

	/**
	 * set the iso / code system name mapping
	 * 
	 * @param isoMap
	 */
	public void setNameToIsoMap(Map<String, String> isoMap) {
		this.nameToIsoMap = isoMap;
		loadNameToIsoMap();
	}

	/**
	 * Get the code system name to search against. If the iso code is passed in
	 * then it will attempt to resolve the code system name in UMLS such as
	 * SNOMEDCT. If a mapping is not found it will return the passed in value
	 * assuming that it is already a code system name
	 * 
	 * @param isoID
	 * @return
	 */
	private String getSystemName(String isoID) {
		if (isoToNameMap.containsKey(isoID)) {
			return isoToNameMap.get(isoID);
		}
		return isoID;
	}

	/**
	 * Load the mapping info from a file.
	 * 
	 * @param fileName
	 *            the file to load the info from
	 * @param clear
	 *            whether or not to clear the current mapping or not
	 * @throws Exception
	 */
	public void loadIosMap(String fileName, boolean clear) throws Exception {
		if (clear) {
			nameToIsoMap.clear();
		}

		BufferedReader in;
		int lineNo = 1;
		in = new BufferedReader(new InputStreamReader(getClass()
				.getResourceAsStream(fileName)));
		String line = in.readLine();
		while (line != null) {
			if (!line.startsWith("#") && line.length() > 0) {
				String[] foo = line.split("=");
				if (foo.length == 2) {
					nameToIsoMap.put(foo[0], foo[1]);
				} else {
					throw new Exception("Invalid format on line " + lineNo);
				}
			}
			line = in.readLine();
			lineNo++;
		}
		in.close();
		loadNameToIsoMap();
	}

	/**
	 * load the reverse mapping for the iso / code system name mapping
	 */
	private void loadNameToIsoMap() {
		isoToNameMap.clear();
		for (Map.Entry<String, String> entry : nameToIsoMap.entrySet()) {
			isoToNameMap.put(entry.getValue(), entry.getKey());
		}

	}

	/**
	 * Close the connection statement and result set, trapping and dealing with
	 * errors.
	 * 
	 * @param conn
	 * @param stmt
	 * @param rset
	 */
	private void closeConnectionAndStatement(Connection conn, Statement stmt,
			ResultSet rset) {
		try {
			rset.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
