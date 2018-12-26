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
                        <td>NO ID Card</td>
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
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td><strong>Emergency Contact</strong></td>
                        <td></td>
                        <td style="text-align: right">
                            <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#myModal">Add Kontak</button></td>

                    </tr>


                </table>
                <div id="gridbox" style="width: 100%; height: 100px; background-color: white;" onchange="onUpdate();"></div>
                <label id="Content" style="display: none"><%: GridContent %></label>
                <label id="JsonContent" style="display: none" runat="server"></label>
            </div>
        </div>
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h6>Data Kerabat</h6>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

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

            //membuat menu
            myMenu = new dhtmlXMenuObject({
                icons_path: "../Project/Asset/",
                context: true,
                items: [
                    //{id :"update", text:"Update", img:"update.png"},
                    { id: "delete", text: "Delete", img: "delete.png" }
                ]
            });

            myMenu.renderAsContextMenu();
            myMenu.attachEvent("onClick", function () {
                var selectedRow = myGrid.getSelectedId();
                var rIndex = myGrid.getRowIndex(selectedRow);
                var ObjectID = myGrid.cellByIndex(rIndex, 0).getValue();
                DeleteFile(ObjectID);
            });

            //membuat Grid

            var gridContent = JSON.stringify(content);
            myGrid = new dhtmlXGridObject('gridbox');
            myGrid.setHeader("ID,Nama,Alamat,Kota,No Telp");
            myGrid.setColumnIds("idxKerabat,nm_kerabat,almt_kerabat,kota_kerabat,kntk_kerabat");
            myGrid.setInitWidths("*,*,*,*,*");
            //myGrid.attachHeader("&nbsp,#text_filter,#text_filter,#text_filter;");
            //myGrid.setSizes("100,100,100,*");
            myGrid.enableAutoHeight(true);
            //myGrid.setSkin("Material");

            //myGrid.enableResizing(true,true,true,true,true);
            //myGrid.setHeight("200);
            myGrid.setColumnHidden(0, true);
            myGrid.setColAlign("left,left,left,left,left");
            myGrid.setColTypes("ro,ed,ed,ed,ed");
            myGrid.setColSorting("str");
            myGrid.init();
            myGrid.parse(content, "js");
            myGrid.enableContextMenu(myMenu);
        }
        function DeleteFile(ObjectID) {
            w2popup.open({
                title: 'Delete Folder',
                body: '<iframe name=myIframeDelete src="DeleteFile.aspx?rowid=' + ObjectID + '&action=3" width="360px" height="50px" frameBorder="0" runat="server"></iframe>',
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
