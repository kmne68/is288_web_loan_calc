<%-- 
    Document   : LoanCalc
    Created on : Aug 29, 2017, 7:10:44 PM
    Author     : kmne6
--%>

<%@page import="java.text.NumberFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="business.Loan"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Loan Results</title>
    </head>
    <body>
        <h1>Monthly Loan Schedule</h1>

        <%
            try {
                double principle = Double.parseDouble(request.getParameter("prinbal"));
                double rate = Double.parseDouble(request.getParameter("intrate"));
                int term = Integer.parseInt(request.getParameter("term"));

                Loan loan = new Loan(principle, rate, term);

                // formatters
                NumberFormat curr = NumberFormat.getCurrencyInstance();
        %>

        <p>A payment of <%=curr.format(loan.getMonthlyPayment())%> is required to 
            pay off a loan of <%=loan.getPrincipal()%> in 
            <%=loan.getTerm()%> months at a rate of: <%=loan.getRate()%></p>

        <table border="1">
            <tr>
                <th>Month</th>
                <th>Beg. Bal.</th>
                <th>Int. Charged</th>
                <th>Prin. Amt</th>
                <th>End. Bal.</th>
            </tr>

            <%
                for (int month = 1; month <= loan.getTerm(); month++) {
            %>
            <tr>
                <td align="right"><%= month%></td>
                <td align="right"><%= curr.format(loan.getBegBal(month))%></td>
                <td align="right"><%= curr.format(loan.getIntCharged(month))%></td>
                <td align="right"><%= curr.format(loan.getMonthlyPayment() - loan.getIntCharged(month))%></td>
                <td align="right"><%= curr.format(loan.getEndBal(month))%></td>
            </tr>    
            <% } %>
        </table>>

        <% } catch (Exception e) {%>
        <br>
        <p>Process error on data validation
            <%= e.getMessage()%>. Use back arrow to retry.</p>
            <% }%>
    </body>
</html>
