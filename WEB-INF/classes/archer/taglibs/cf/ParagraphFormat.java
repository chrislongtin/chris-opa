//===========================================================================
// Archer Software, Ltd. @{SRCH}
//								ParagraphFormat.java
//
//---------------------------------------------------------------------------
// DESCRIPTION: @{HDES}
// -----------
// OPAV: custom tag ParagraphFormat.
// Replaces characters in a string: 
//    Single newline characters (CR/LF sequences) with spaces.
//    Double newline characters with HTML paragraph tags (<p>).
//
//---------------------------------------------------------------------------
// CHANGES LOG: @{HREV}
// -----------
// Revision: 01.00
// By      : Pavel Ivashkov
// Date    : 7/10/03 01:50:54 PM
//===========================================================================
 
package archer.taglibs.cf;

import java.io.*;
import javax.servlet.jsp.*;
import javax.servlet.jsp.el.*;
import javax.servlet.jsp.tagext.*;

/**
 * <summary>Custom tag for string formatting.</summary>
 * <example>
 * In a JSP page put the following tag in the place where the string
 * should appear:
 * <code>
 *		<ParagraphFormat value="${string expression}" />
 * </code>
 * </example>
 */
public final class ParagraphFormat extends TagSupport
{
	//===========================================================================
	//                                 Tag Logic
	//===========================================================================
	public int doStartTag() throws JspException
	{
		evaluateExpressionsInAttributes();		
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
			throw new JspTagException( "ParagraphFormat tag failed to write its contents.", ex );
		}
		
		return EVAL_PAGE;
	}

	//===========================================================================
	//                                 Attributes
	//===========================================================================
	private String value;
	private String valueEl;

	public void setValue( String val )		// value
	{
		valueEl = val;
	}

	/// <summary>Expands expressions in attribute values.</summary>
	private void evaluateExpressionsInAttributes() throws JspTagException
	{
		try
		{
			value = evalString( valueEl );
		}
		catch( ELException ex )
		{
			throw new JspTagException( "ParagraphFormat tag failed to evaluate attribute value.", ex );
		}
	}
	
	/// <summary>Evaluates string expression.</summary>
	private String evalString( String expr ) throws ELException
	{
		ExpressionEvaluator ee = pageContext.getExpressionEvaluator();
		String sval = (String) ee.evaluate(
			expr,
			String.class,
			pageContext.getVariableResolver(),
			null );
		return sval;
	}

	//===========================================================================
	//                                 Implementation
	//===========================================================================

	/// <summary>Returns body of the tag.</summary>
	private String evalBody() throws JspTagException
	{
		value = value.replaceAll( "(\r\n){2}|(\n\r){2}|\r{2}|\n{2}", "<p>" );
		return value.replaceAll( "(\r\n)|(\n\r)|[\r\n]", " " ) + "<p>";
	}
}
//===========================================================================
//                              End of ParagraphFormat.java
//===========================================================================
