package opa;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Enumeration;
import java.util.ResourceBundle;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * This class will retrieve messages from the database instead of a message
 * resource file.
 * 
 * @author Chris Longtin
 * @email chris.longtin@gmail.com
 * 
 */
public class DatabaseResourceBundle extends ResourceBundle {

    private final static Log log = LogFactory.getLog(DatabaseResourceBundle.class);

    Integer langId;
    String jndiJdbc;
    
    public DatabaseResourceBundle(String jndiJdbc, Integer langId) {
        setLangId(langId);
        setJndiJdbc(jndiJdbc);
    }

    @Override
    public Enumeration<String> getKeys() {
        String sql = "SELECT phrase FROM phrases WHERE lang_id = " + langId;

        ArrayList<String> values = new ArrayList<String>();
        
        try {
            Connection conn = getConnection();
            ResultSet rs = getConnection().createStatement().executeQuery(sql);

            if (rs.next())
                values.add("phrase");
            
            releaseConnection(conn);
        } catch (Exception e) {
            log.error(e, e);
        }

        return Collections.enumeration(values);    
    }

    @Override
    protected Object handleGetObject(String key) {
        String sql = "SELECT phrase FROM phrases WHERE phrase_id = "
                + key + " AND lang_id = " + langId;

        String value = null;
        
        try {
            Connection conn = getConnection();
            ResultSet rs = getConnection().createStatement().executeQuery(sql);

            if (rs.next())
                value = rs.getString("phrase");
            
            releaseConnection(conn);
        } catch (Exception e) {
            log.error(e, e);
        }

        return value;    
    }
    
    /**
     * Return a database connection. null if one cannot be achieved.
     * 
     * @return
     */
    private Connection getConnection() {
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/" + jndiJdbc);
            return ds.getConnection();        
        }
        catch(NamingException e) {
            log.error("java:comp/env/" + jndiJdbc + " not found!", e);
        } catch (SQLException e) {
            log.error(e, e);
        }
        
        return null;
    }

    /**
     * Try and release the given database connection.
     * 
     * @param conn
     *            true if successful or if it was already closed/null, false if
     *            the close operation failed.
     * @return
     */
    private boolean releaseConnection(Connection conn) {
        try {
            if(conn != null && !conn.isClosed()) {
                conn.close();
            }
            
            return true;
        }        
        catch(SQLException e) {
            return false;
        }
    }

    public Integer getLangId() {
        return langId;
    }

    public void setLangId(Integer langId) {
        this.langId = langId;
    }

    public String getJndiJdbc() {
        return jndiJdbc;
    }

    public void setJndiJdbc(String jndiJdbc) {
        this.jndiJdbc = jndiJdbc;
    }
}
