<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="MasterPerusahaan.aspx.cs" Inherits="NineOrchid.Pages.Project.MasterPerusahaan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentItem" runat="server">
    <form role="form" runat="server" class="Content-custom-wrapper">
        <asp:Panel runat="server" ID="panelInfo" Visible="false" CssClass="alert alert-success">
            <strong>
                <asp:Label ID="infolbl" runat="server"></asp:Label></strong>
        </asp:Panel>


        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title"><strong>Master Perusahaan Tempat Penghuni Bekerja</strong></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->


            <div class="box-body">
                <div class="form-group">
                    <label for="exampleInputEmail1">Nama Perusahaan</label>
                    <asp:TextBox CssClass="form-control" ID="nmperusahaan" runat="server"></asp:TextBox>

                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Alamat</label>
                    <asp:TextBox CssClass="form-control" ID="almt_perusahaan" runat="server" TextMode="multiline" Columns="20" Rows="2"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Kota</label>
                    <asp:TextBox CssClass="form-control" ID="kota_perusahaan" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Telp</label>
                    <asp:TextBox CssClass="form-control" ID="telp_perusahaan" runat="server"></asp:TextBox>
                </div>
            </div>
            <!-- /.box-body -->

            <div class="box-footer">
                <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="btnSubmit" OnClick="btnSubmit_Click" Text="Submit" />
            </div>
        </div>
        <div class="box box-primary">
            <div class="box-header with-border">
                <h3 class="box-title"><strong>Tabel Perusahaan</strong></h3>
            </div>
            <div class="box-body">
                <div id="gridbox" style="width: 100%; height: 100px; background-color: white;" onchange="onUpdate();"></div>
                <label id="Content" style="display: none"><%: GridContent %></label>
                <label id="JsonContent" style="display: none" runat="server"></label>
            </div>

            <div class="box-footer">
            </div>
        </div>
    </form>

    <script>
        var myGrid, formData;
        function doOnload() {
            debugger

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
            myGrid.setColumnIds("idxPerusahaan,nm_perusahaan,almt_perusahaan,kota_perusahaan,telp_perusahaan");
            myGrid.setInitWidths("*,*,*,*,*");
            //myGrid.attachHeader("&nbsp,#text_filter,#text_filter,#text_filter;");
            myGrid.enableAutoHeight(true);
            myGrid.setColumnHidden(0, true);
            myGrid.setColAlign("left,left,left,left,left");
            myGrid.setColTypes("ro,ro,ro,ro,ro");
            myGrid.setColSorting("str");
            //var combobox = myGrid.getCombo(3);
            //combobox.put("Printed", "Printed");
            //combobox.put("eBook", "eBook");
            //var comboboxKategori = myGrid.getCombo(5);
            //comboboxKategori.put("Matahari", "Matahari");
            //comboboxKategori.put("Gramedia Nusantara", "Gramedia Nusantara");
            //comboboxKategori.put("Erlangga", "Erlangga");

            //myGrid.setColumnHidden(0, true);
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
    </script>
</asp:Content>
