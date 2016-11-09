<%--
 Copyright 2003 Sun Microsystems, Inc. All rights reserved.
 SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
--%>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tck" uri="http://java.sun.com/jstltck/jstltck-util" %>
<%@ page import="javax.sql.*, java.util.*" %>

<tck:test testName="positiveQueryBodyContentTest">

   <!-- Validate that a Simple SQL Query will return
              a non empty ResultSet -->

   <h1>Validating sql:query action specifying query as body content </h1>
   <p>


   <sql:query var="resultSet2"
                 dataSource='<%=(DataSource) pageContext.getAttribute("jstlDS", PageContext.APPLICATION_SCOPE) %>'  >
       <%=((Properties)pageContext.getAttribute("sqlProps",PageContext.APPLICATION_SCOPE)).getProperty("Simple_Select_Query") %>
   </sql:query>

   <c:choose>
      <c:when test="${resultSet2.rowCount != JSTL_TAB1_ROWS}">
         <H2>ERROR:</H2>
         The query: <strong>
         "<c:out value="${sqlProps.Simple_Select_Query}" />"
         </strong> returned <strong>"<c:out value="${resultSet2.rowCount}" />"
         </strong> rows and the expected number of rows was
         <strong>"<c:out value="${JSTL_TAB1_ROWS}" />"</strong>.
         <p>
      </c:when>
      <c:otherwise>
         The query did return a Result Object that contained
         <strong><c:out value="${JSTL_TAB1_ROWS}" /></strong> rows.
         <p>
      </c:otherwise>
   </c:choose>

</tck:test>