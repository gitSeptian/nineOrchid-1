<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="DetailPenghuni.aspx.cs" Inherits="NineOrchid.Pages.Project.DetailPenghuni" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentItem" runat="server">
    <style>
        td {
            padding: 5px;
        }
    </style>
    <form role="form" runat="server" style="padding: 20px 20px 1px 35px">
        <div class="box box-default">
            <div class="box-header with-border">
                <h4 class="box-title pull-left">Detail Penghuni</h4>
            </div>
            <div class="box-body">
                <table>
                    <tr>
                        <td>Nama</td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="labelNama" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>TTL</td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="labelTTL" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Alamat Asal</td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="labelAlamat" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Agama</td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="labelAgama" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>No ID Card</td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="labelid" runat="server"></asp:Label></td>
                    </tr>

                    <tr>
                        <td>No HP</td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="labelnoHP" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="labelEmail" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Pekerjaan</td>
                        <td>: </td>
                        <td>
                            <asp:Label ID="labelPekerjaan" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Foto Penghuni</td>
                        <td>:</td>
                        <td><asp:Image ID="image" runat="server" AlternateText="No Upload File Found" Width="200px" Height="150px"/></></td>
                    </tr>
                    <tr>
                        <td><strong>Emergency Contact</strong></td>
                        <td></td>
                        <td style="text-align: right">
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">Add Kontak</button></td>

                    </tr>


                </table>
                 <table id="myTable" class="table table-responsive table-bordered table-striped">

                            <thead class="panel panel-default">
                            </thead>

                            <tbody class="">
                            </tbody>
                        </table>
                <label id="Content" style="display: none"><%: GridContent %></label>
                <label id="JsonContent" style="display: none" runat="server"></label>
            </div>
        </div>
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                       
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Kontak</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="exampleInputPassword1">Nama</label><br />
                            <asp:TextBox CssClass="form-control" ID="namaKerabat" runat="server"></asp:TextBox>
                        </div>
                             <div class="form-group">
                            <label for="exampleInputPassword1">Kontak</label><br />
                            <asp:TextBox CssClass="form-control" ID="kontakkerabat" runat="server"></asp:TextBox>
                        </div>
                             <div class="form-group">
                            <label for="exampleInputPassword1">Alamat</label><br />
                            <asp:TextBox CssClass="form-control" ID="alamatkerabat" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </div>
                             <div class="form-group">
                            <label for="exampleInputPassword1">Kota</label><br />
                            <asp:TextBox CssClass="form-control" ID="kotakerabat" runat="server"></asp:TextBox>
                        </div>
                             <div class="form-group">
                            <label for="exampleInputPassword1">Hubungan</label><br />
                            <asp:TextBox CssClass="form-control" ID="hubungan" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button ID="submitKerebat" Text="Add" CssClass="btn" runat="server" OnClick="submitKerebat_Click"></asp:Button>
                    </div>
                </div>

            </div>
        </div>
    </form>


    <script>
        var myGrid, formData;
        function doOnload() {


            var testing = eval("(" + $("#Content").text() + ")");
            var insert = testing.DocumentElement.data;

            var content;
            if (insert instanceof Array) {
                content = insert;
            }
            else {
                content = [insert];
            }

            $('#myTable').dataTable(
{
    data: content,
    "ordering": false,
    "info":     false,
    columns: [

        { title: "Nama", data: "nm_kerabat" },
        { title: "Alamat", data: "almt_kerabat" },
         { title: "Kota", data: "kota_kerabat" },
          { title: "No Telp", data: "kntk_kerabat" },
          { title: "Hubungan Saudara", data: "hub_dgn_penghuni" },
          { title: "", data: "idxKerabat", "className": "text-center", mRender: function (id) { var param = id.toString(); return "<button href='#'  class='btn btn-danger btn-xs' data-title='Delete' onClick=DeleteFile(" + id + ") style='margin-left:5px'><span class='glyphicon glyphicon-remove'></button>"; } }
    ]
}

);
        }
        function DeleteFile(ObjectID) {
            w2popup.open({
                title: 'Delete Folder',
                body: '<iframe name=myIframeDelete src="DeleteFile.aspx?rowid=' + ObjectID + '&action=4" width="360px" height="50px" frameBorder="0" runat="server"></iframe>',
                width: 380,
                height: 100,
                overflow: 'hidden',
                color: '#333',
                speed: '0.3',
                opacity: '0.8',
                modal: true,


            });
        }
        function GoDetails() {
            alert("success");
        }
    </script>
</asp:Content>
