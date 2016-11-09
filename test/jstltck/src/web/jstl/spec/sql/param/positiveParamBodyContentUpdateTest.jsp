<%--
 Copyright 2003 Sun Microsystems, Inc. All rights reserved.
 SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ taglib prefix="tck" uri="http://java.sun.com/jstltck/jstltck-util" %>
<%@ page import="javax.sql.*, java.util.*" %>

<tck:test testName="positiveParamBodyContentUpdateTest">

   <%
      pageContext.setAttribute("key", new Integer("1"));
      pageContext.setAttribute("lastName", "Kent");
   %>
   <%-- Number of rows to be affected by the DML statements --%>
   <c:set var="expectedRowsAffected" value="${1}" />

  <!-- Validate ability to utilize  sql:update sql:param actions and
             specifying a parameter as body content to execute the query-->

   <h1>Validating sql:update action by specifying multiple sql:param actions and
   specifying a parameter as body content via RT</h1>
   <p>
   <%-- Clear out our table prior to starting the test --%>
   <sql:update var="updateCount" dataSource="${applicationScope.jstlDS}">
       <c:out value="${sqlProps.Delete_AllRows_Query}" />
   </sql:update>

   <sql:update var="updateCount" dataSource="${applicationScope.jstlDS}">
       <c:out value="${sqlProps.Insert_Row_Query}" escapeXml='false'/>
   </sql:update>

   <sql:update var="updateCount2"
                  dataSource='<%=(DataSource) pageContext.getAttribute("jstlDS", PageContext.APPLICATION_SCOPE) %>' >
      <c:out value="${sqlProps.Delete_Jstl_Tab2_MultiParam_Query}" escapeXml='false' />
      <sql:param value='<%= pageContext.getAttribute("key") %>' />
      <sql:param  >
         <c:out value='${lastName}' />
      </sql:param>
   </sql:update>

   <c:choose>
       <c:when test="${updateCount2 == expectedRowsAffected}">
        The SQL statement executed correctly and  returned the correct
        update count of <strong><c:out value="${expectedRowsAffected}" />
        </strong>.<p>
       </c:when>
       <c:otherwise>
         <strong>Error:</strong> The SQL statement "<strong>
         "<c:out value="${sqlProps.Delete_Jstl_Tab2_MultiParam_Query}" />"
         </strong> which was executed with the parameter values of  <strong>
         <c:out value='${key}' /></strong> and <strong>
         <c:out value='${lastName}'/></strong>, resulted in an update count of
         <strong> <c:out value="${updateCount2}" /></strong> and the
          the expected update count was <strong>
          <c:out value="${expectedRowsAffected}" /></strong>!<p>
       </c:otherwise>
   </c:choose>



</tck:test>