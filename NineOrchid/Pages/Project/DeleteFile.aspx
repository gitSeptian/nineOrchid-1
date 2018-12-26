<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DeleteFile.aspx.cs" Inherits="NineOrchid.Pages.Project.DeleteFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" >
        function RefreshParent() {
            window.parent.location.href = window.parent.location.href;
        }
</script>
</head>
<body>
    <form id="form6" runat="server" method="post" target="myIframeDelete" >  
        <table class="test">
         <tr>                   
         <td>
          Delete "<asp:Label ID="lblFileName" runat="server"></asp:Label>" ?
         </td>
         <td>          
        <asp:Button ID="btnDelete" runat="server" Text="Yes" Width="35px" OnClick="btnDelete_Click"/>              
         </td>
          <td>          
        <asp:Button ID="btnCancel" runat="server" Text="No" Width="35px" OnClick="btnCancel_Click"/>              
         </td>
         </tr>
        </table>
</form>
</body>
