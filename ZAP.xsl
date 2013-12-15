<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" />
	<xsl:template match="/alerts">
		<html>
			<head>
				<title>Zap Reports</title>
				<style>
					html, body, div, span, applet, object, iframe,
					h1, h2, h3, h4, h5, h6, p, blockquote, pre,
					a, abbr, acronym, address, big, cite, code,
					del, dfn, em, font, img, ins, kbd, q, s, samp,
					small, strike, strong, sub, sup, tt, var,
					b, u, i, center,
					dl, dt, dd, ol, ul, li,
					fieldset, form, label, legend,
					table, caption, tbody, tfoot, thead, tr, th, td {
						margin: 0;
						padding: 0;
						border: 0;
						outline: 0;
						font-size: 100%;
						vertical-align: baseline;
						background: transparent;
					}
					body {
						line-height: 1;
					}
					ol, ul {
						list-style: none;
					}
					blockquote, q {
						quotes: none;
					}
					blockquote:before, blockquote:after,
					q:before, q:after {
						content: '';
						content: none;
					}

					/* remember to define focus styles! */
					:focus {
						outline: 0;
					}

					/* remember to highlight inserts somehow! */
					ins {
						text-decoration: none;
					}
					del {
						text-decoration: line-through;
					}

					/* tables still need 'cellspacing="0"' in the markup */
					table {
						border-collapse: collapse;
						border-spacing: 0;
					}

					.bReport {
						font: 12px Arial, sans-serif;
						padding: 20px;
					}

					.bReport__eTitle {
						font-size: 30px;
						text-align: center;
					}

					.bReport__eTable {
						width: 100%;
						margin-top: 20px;
					}

					.bReport__eTable__mInner {
						margin: 0;
					}

					.bReport__eTable__mInner .bReport__eTable__eItem {
						border: none;
						border-bottom: 1px #ddd solid;
					}

					.bReport__eTable__eItems {

					}

					.bReport__eTable__eItems__mLevelInfo .bReport__eTable__eItem__mRisk {
						color: #31708f;
						background: #d9edf7;
					}

					.bReport__eTable__eItems__mLevelLow .bReport__eTable__eItem__mRisk {
						color: #8a6d3b;
						background: #fcf8e3;
					}

					.bReport__eTable__eItems__mLevelMedium .bReport__eTable__eItem__mRisk {
						color: #3c763d;
						background: #dff0d8;
					}

					.bReport__eTable__eItems__mLevelHigh .bReport__eTable__eItem__mRisk {
						color: #a94442;
						background: #f2dede;
					}

					.bReport__eTable__eItem {
						border: 1px #ddd solid;
						padding: 10px;
					}

					.bReport__eTable__eItem__mComposite {
						width: 50%;
						padding: 0;
					}

					.bReport__eTable__eItem__mLast {
						border: none !important;
					}

					.bReport__eTable__eItem__mHead {
						font-size: 18px;
					}

					.bReport__eTable__eItem__mRisk {
						text-align: center;
						vertical-align: middle;
					}

					.bReport__eTable__eItem__mUrl,
					.bReport__eTable__eItem__mAttack {
						font-family: monospace;
						word-break: break-all;
					}

					.bReport__eTable__eItem__mUrl {
						vertical-align: middle;
					}

					.bReport__eTable__eItem__mAlert {
						font-size: 16px;
					}

					.bReport__eTable__eItem__mDesc {
						color: #666;
					}
				</style>
			</head>
			<body>
				<div class="bReport">
					<h1 class="bReport__eTitle">Report Alerts</h1>
					<table class="bReport__eTable">
						<thead>
							<tr>
								<th class="bReport__eTable__eItem bReport__eTable__eItem__mHead">Risk</th>
								<th class="bReport__eTable__eItem bReport__eTable__eItem__mHead">URL</th>
								<th class="bReport__eTable__eItem bReport__eTable__eItem__mHead">Alert</th>
							</tr>
						</thead>
						<tbody>
							<xsl:apply-templates select="alert[starts-with(risk, 'High')]">
								<xsl:sort select="alert" />
							</xsl:apply-templates>
							<xsl:apply-templates select="alert[starts-with(risk, 'Medium')]">
								<xsl:sort select="alert" />
							</xsl:apply-templates>
							<xsl:apply-templates select="alert[starts-with(risk, 'Low')]">
								<xsl:sort select="alert" />
							</xsl:apply-templates>
							<xsl:apply-templates select="alert[starts-with(risk, 'Informational')]">
								<xsl:sort select="alert" />
							</xsl:apply-templates>
						</tbody>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="alert">
		<tr>
			<xsl:attribute name="class">
				<xsl:text>bReport__eTable__eItems</xsl:text>
				<xsl:text> bReport__eTable__eItems__mLevel</xsl:text>
				<xsl:if test="risk = 'Low'">
					<xsl:text>Low</xsl:text>
				</xsl:if>
				<xsl:if test="risk = 'Informational'">
					<xsl:text>Info</xsl:text>
				</xsl:if>
				<xsl:if test="risk = 'Medium'">
					<xsl:text>Medium</xsl:text>
				</xsl:if>
				<xsl:if test="risk = 'High'">
					<xsl:text>High</xsl:text>
				</xsl:if>
			</xsl:attribute>
			<td class="bReport__eTable__eItem bReport__eTable__eItem__mRisk">
				<xsl:value-of select="risk" />
			</td>
			<td class="bReport__eTable__eItem bReport__eTable__eItem__mUrl">
				<xsl:value-of select="url" />
			</td>
			<td class="bReport__eTable__eItem bReport__eTable__eItem__mComposite">
				<table class="bReport__eTable bReport__eTable__mInner">
					<tr>
						<td class="bReport__eTable__eItem bReport__eTable__eItem__mAlert">
							<xsl:value-of select="alert" />
						</td>
					</tr>
					<tr>
						<td>
							<xsl:attribute name="class">
								<xsl:text>bReport__eTable__eItem</xsl:text>
								<xsl:text> bReport__eTable__eItem__mDesc</xsl:text>
								<xsl:if test="attack = ''"> bReport__eTable__eItem__mLast</xsl:if>
							</xsl:attribute>
							<xsl:value-of select="description" />
						</td>
					</tr>
					<xsl:if test="attack != ''">
						<tr>
							<td class="bReport__eTable__eItem bReport__eTable__eItem__mAttack bReport__eTable__eItem__mLast">
								<xsl:value-of select="attack" />
							</td>
						</tr>
					</xsl:if>
				</table>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>