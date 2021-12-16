<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>
  
  <!-- document outline --> 
  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>FraCas Project</title>
        <style>
          body {
            font-family: Lucida Sans, Arial, Helvetica, sans-serif;
            font-size: 12px;
          }
          td {
            font-family: Lucida Sans, Arial, Helvetica, sans-serif;
            font-size: 12px;
          }
          td.prob-id {
            width: 100px;
          }
		  
		  td.prob-language {
            width: 100px;
          }
		  
          td.prob-fracas-ans {
            width: 150px;
          }
          div.comment {
            background: #cccccc;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
          }
          h1 {
            background: #ffffcc;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
          }
          h2 {
            background: #ffffcc;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
          }
          h3 {
            background: #ffffcc;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
          }
          div.problem {
            background: #C8DBFF;
            padding: 10px;
            margin-top: 10px;
            margin-bottom: 10px;
          }
        </style>
      </head>
      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  
  <!-- comment -->

  <xsl:template match="comment[@class='intro']">
    <div class="comment">
      <pre> <xsl:value-of select="text()"/> </pre>
    </div>
  </xsl:template>

  <xsl:template match="comment[@class='section']">
    <h1>
      <xsl:value-of select="text()"/>
    </h1>
  </xsl:template>

  <xsl:template match="comment[@class='subsection']">
    <h2>
      <xsl:value-of select="text()"/>
    </h2>
  </xsl:template>

  <xsl:template match="comment[@class='subsubsection']">
    <h3>
      <xsl:value-of select="text()"/>
    </h3>
  </xsl:template>

  <xsl:template match="comment">
    <div class="comment" id="{@id}">
      <pre> <xsl:value-of select="text()"/> </pre>
    </div>
  </xsl:template>

  <!-- problem -->
  <xsl:template match="problem">
    <div class="problem">
      <table>
        <tr>

          <!-- id -->
          <td class="prob-id">
            fracas-<xsl:value-of select="@id"/>
          </td>
		  
		   <td class="prob-language">
            lang: <xsl:value-of select="@language"/>
          </td>

          <!-- fracas_answer -->
          <xsl:if test="@fracas_answer">
            <td class="prob-fracas-ans">
              answer: 
              <xsl:choose>
                <xsl:when test="@fracas_answer='yes'">
                  <font color="green">
                    <xsl:value-of select="@fracas_answer"/>
                  </font>
                </xsl:when>
                <xsl:when test="@fracas_answer='no'">
                  <font color="red">
                    <xsl:value-of select="@fracas_answer"/>
                  </font>
                </xsl:when>
                <xsl:when test="@fracas_answer='undef'">
                  <font color="fuchsia">
                    <xsl:value-of select="@fracas_answer"/>
                  </font>
                </xsl:when>
                <xsl:otherwise>
                  <font color="black">
                    <xsl:value-of select="@fracas_answer"/>
                  </font>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:if test="@fracas_nonstandard='true'">
                **
              </xsl:if>
            </td>
          </xsl:if>

        </tr>
      </table>

      <table width="100%">
        <xsl:apply-templates select="p"/>
        <xsl:apply-templates select="q"/>
        <xsl:apply-templates select="h"/>
        <xsl:apply-templates select="a"/>        
        <xsl:apply-templates select="why"/>
        <xsl:apply-templates select="note"/>
      </table>

    </div>
  </xsl:template>

  <!-- premise -->
  <xsl:template match="p">
    <tr>
      <td width="60" valign="top">
        P<xsl:value-of select="@idx"/>
      </td>
    </tr>
	<tr>
	  <td valign="top"> script </td>
	  <td colspan="2">
        <xsl:value-of select="script"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> translit </td>
	  <td colspan="2">
        <xsl:value-of select="translit"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> ipa </td>
	  <td colspan="2">
        <xsl:value-of select="ipa"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> morph </td>	
      <td colspan="2">
        <xsl:value-of select="morph"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> English </td>	
	  <td colspan="2">
        <xsl:value-of select="english"/>
      </td>
    </tr>
  </xsl:template>

  <!-- question -->
  <xsl:template match="q">
    <tr>
      <td valign="top"> Q </td>
      <td colspan="2">
      </td>
    </tr>
		<tr>
	  <td valign="top"> script </td>
	  <td colspan="2">
        <xsl:value-of select="script"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> translit </td>
	  <td colspan="2">
        <xsl:value-of select="translit"/>
      </td>
	</tr>
	  <tr>
	<td valign="top"> ipa </td>
	  <td colspan="2">
        <xsl:value-of select="ipa"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> morph </td>	
      <td colspan="2">
        <xsl:value-of select="morph"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> English </td>	
	  <td colspan="2">
        <xsl:value-of select="english"/>
      </td>
    </tr>
  </xsl:template>
  
  <!-- hypothesis -->
  <xsl:template match="h">
    <tr>
      <td valign="top"> H </td>
      <td colspan="2">
      </td>
    </tr>
		<tr>
	  <td valign="top"> script </td>
	  <td colspan="2">
        <xsl:value-of select="script"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> translit </td>
	  <td colspan="2">
        <xsl:value-of select="translit"/>
      </td>
	</tr>
	  <tr>
	<td valign="top"> ipa </td>
	  <td colspan="2">
        <xsl:value-of select="ipa"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> morph </td>	
      <td colspan="2">
        <xsl:value-of select="morph"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> English </td>	
	  <td colspan="2">
        <xsl:value-of select="english"/>
      </td>
    </tr>
  </xsl:template>
  
  <!-- full answer -->
  <xsl:template match="a">
    <tr>
      <td valign="top"> A </td>
      <td colspan="2">
      </td>
    </tr>
		<tr>
	  <td valign="top"> script </td>
	  <td colspan="2">
        <xsl:value-of select="script"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> translit </td>
	  <td colspan="2">
        <xsl:value-of select="translit"/>
      </td>
	</tr>
	  <tr>
	<td valign="top"> ipa </td>
	  <td colspan="2">
        <xsl:value-of select="ipa"/>
      </td>
	</tr>
	<tr>
	<td valign="top"> English </td>	
	  <td colspan="2">
        <xsl:value-of select="english"/>
      </td>
    </tr>
  </xsl:template>

  <!-- why -->
  <xsl:template match="why">
    <tr>
      <td valign="top"> Why </td>
      <td colspan="2">
        <i> <xsl:copy-of select="text()|node()" /> </i>
      </td>
    </tr>
  </xsl:template>

  <!-- note -->
  <xsl:template match="note">
    <tr>
      <td valign="top"> Note </td>
      <td colspan="2">
        <i> <xsl:copy-of select="text()|node()" /> </i>
      </td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet> 
