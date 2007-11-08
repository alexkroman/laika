package org.projectlaika.validator.codesystem;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.projectlaika.validator.codesystem.UMLSValidator;
import org.projectlaika.validator.codesystem.XSLTValidator;

import junit.framework.TestCase;

public class XSLTTest extends TestCase{

	
	public void testXSLT()throws Exception{
		String[] args = {"-IN","src/test/resources/test.xml","-XSL","src/test/resources/test.xslt"};
		try {
			UMLSValidator val = new UMLSValidator("/UMLS_SAB_OID_Map.txt");	
			final String url = "jdbc:mysql://octagon/umls";
			final String driver = "org.gjt.mm.mysql.Driver";
			Class.forName(driver, true, getClass().getClassLoader());	
			DataSource source = new DataSource() {
				
				PrintWriter log;
				public void setLoginTimeout(int seconds) throws SQLException {
					// TODO Auto-generated method stub
			
				}
			
				public void setLogWriter(PrintWriter out) throws SQLException {
					
					log = out;
				}
			
				public int getLoginTimeout() throws SQLException {
					// TODO Auto-generated method stub
					return 0;
				}
			
				public PrintWriter getLogWriter() throws SQLException {
					// TODO Auto-generated method stub
					return log;
				}
			
				public Connection getConnection(String username, String password)
						throws SQLException {
					
					
					DriverManager.setLoginTimeout(10);
				    Properties props = new Properties();
	                props.setProperty("user", username);
	                props.setProperty("password", password);
	                try{
	                return DriverManager.getConnection(url,username,password);
	                }
	                catch(Exception e){
	                	throw new SQLException(e.getMessage());
	                }
	                //return DriverManager.getConnection(url,props);
				}
			
				public Connection getConnection() throws SQLException {
					// TODO Auto-generated method stub
					return getConnection("umls","umls");
				}
			
			};
			
			val.setDataSource(source);
			XSLTValidator.val = val;
            com.sun.org.apache.xalan.internal.xslt.Process._main(args);
        } 
        catch (Exception e) {
           e.printStackTrace();
        }

	}
}
