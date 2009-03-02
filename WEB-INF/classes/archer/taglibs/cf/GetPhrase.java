//===========================================================================
// Archer Software, Ltd. @{SRCH}
//								GetPhrase.java
//
//---------------------------------------------------------------------------
// DESCRIPTION: @{HDES}
// -----------
// OPAV: custom tag GetPhrase.
//       Inserts certain phrase in specified language retreived from the database.
//---------------------------------------------------------------------------
// CHANGES LOG: @{HREV}
// -----------
// Revision: 01.00
// By      : Pavel Ivashkov
// Date    : 7/08/03 06:12:54 PM
//===========================================================================
 
package archer.taglibs.cf;

import java.io.*;
import java.sql.*;
import javax.naming.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.el.*;
import javax.servlet.jsp.jstl.core.Config;
import javax.servlet.jsp.tagext.*;
import javax.sql.*;

/**
 * <summary>Custom tag to retreive certain phrases from the database.</summary>
 * <example>
 * In a JSP page put the following tag in the place where the string
 * should appear:
 * <code>
 *		<GetPhrase lang_id="1" phrase_id="13" />
 * </code>
 * </example>
 */
public final class GetPhrase extends TagSupport
{
	//===========================================================================
	//                                 Tag Logic
	//===========================================================================
	public int doStartTag() throws JspException
	{
		evaluateExpressionsInAttributes();		
		dataSource = locateDefaultDataSource();		
		return SKIP_BODY;
	}

	public int doEndTag() throws JspException
	{
		String body = evalBody();
		JspWriter out	= pageContext.getOut();
		try
		{
			out.write( body );
		}
		catch( IOException ex )
		{
			throw new JspTagException( "GetPhrase tag failed to write its contents.", ex );
		}
		
		return EVAL_PAGE;
	}

	//===========================================================================
	//                                 Attributes
	//===========================================================================
	private int lang_id	= 1;
	private int phrase_id;

	private String langIdEl;
	private String phraseIdEl;

	public void setLang_id( String id )		// lang_id
	{
		langIdEl = id;
	}
	public void setPhrase_id( String id )	// phrase_id
	{
		phraseIdEl = id;
	}

	/// <summary>Expands expressions in attribute values.</summary>
	private void evaluateExpressionsInAttributes() throws JspTagException
	{
		try
		{
			lang_id = evalInt( langIdEl );
			phrase_id = evalInt( phraseIdEl );
		}
		catch( ELException ex )
		{
			throw new JspTagException( "GetPhrase tag failed to evaluate attribute value.", ex );
		}
	}
	
	/// <summary>Evaluates integer expression.</summary>
	private int evalInt( String expr ) throws ELException
	{
		ExpressionEvaluator ee = pageContext.getExpressionEvaluator();
		Integer ival = (Integer) ee.evaluate(
			expr,
			Integer.class,
			pageContext.getVariableResolver(),
			null );
		return ival.intValue();
	}

	//===========================================================================
	//                                 Implementation
	//===========================================================================
	private DataSource dataSource;

	/// <summary>Mimics jstl:sql algorithm to get a reference to a data source.</summary>
	private DataSource locateDefaultDataSource() throws JspTagException
	{
		Object ds = Config.find( pageContext, "javax.servlet.jsp.jstl.sql.dataSource" );
		if( ds == null )
			throw new JspTagException( "GetPhrase tag failed to read \"javax.servlet.jsp.jstl.sql.dataSource\" parameter." );

		if( ds.getClass() == DataSource.class )
			return (DataSource) ds;

		if( ds.getClass() == String.class )
		{
			try
			{
				Context ctx = new InitialContext();
				return (DataSource) ctx.lookup( "java:comp/env/" + (String)ds );
			}
			catch( NamingException ex )
			{
				throw new JspTagException( "GetPhrase tag failed to resolve JNDI data source name.", ex );
			}
		}
		
		throw new JspTagException( "GetPhrase tag: Unknown parameter type " + ds.getClass().toString() + "(javax.servlet.jsp.jstl.sql.dataSource)." );
	}

	/// <summary>Returns body of the tag, i.e. retreived phrase string.</summary>
	private String evalBody() throws JspTagException
	{
		String phrase = "";
		String sql = "SELECT phrase FROM phrases WHERE phrase_id = " + phrase_id + " AND lang_id = " + lang_id;

		try
		{
			Connection conn = dataSource.getConnection();
			Statement stm = conn.createStatement();
			try
			{
				ResultSet rs = stm.executeQuery( sql );
				if( rs.next() )
					phrase = rs.getString(1);
			}
			finally
			{
				stm.close();
				conn.close();
			}
		}
		catch( SQLException ex )
		{
			throw new JspTagException( "GetPhrase tag failed to retreive phrase from database.", ex );
		}

		return phrase;
	}
}
//===========================================================================
//                              End of GetPhrase.java
//===========================================================================
