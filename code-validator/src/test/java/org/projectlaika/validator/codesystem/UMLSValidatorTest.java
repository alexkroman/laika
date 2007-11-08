/**
 * 
 */
package org.projectlaika.validator.codesystem;

import java.io.File;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.projectlaika.validator.codesystem.UMLSValidator;

import com.sun.jmx.snmp.ThreadContext;

/**
 * @author bobd
 *
 */
public class UMLSValidatorTest extends BaseTest {

	
	public UMLSValidatorTest()throws Exception{
		init();
	}

	
	/**
	 * @throws java.lang.Exception
	 */
	protected void init() throws Exception {
		try{
		loadTestsConfig(new File("src/test/resources/umls.properties"));
		final Map<String,String> dbProps = (Map)testConfig.get("database");
		final String url = dbProps.get("url");
		final String driver = dbProps.get("driver");
		Class.forName(driver, true, getClass().getClassLoader());
		UMLSValidator val = new UMLSValidator("/UMLS_SAB_ISO_Map.txt");	
		//System.out.println(val.getIsoMap());
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
				return getConnection(dbProps.get("username"), dbProps.get("password"));
			}
		
		};
		
		val.setDataSource(source);
		setValidator(val);

		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			throw e;
		}
		}




}
