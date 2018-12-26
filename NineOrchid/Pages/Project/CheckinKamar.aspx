<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="CheckinKamar.aspx.cs" Inherits="NineOrchid.Pages.Project.CheckinKamar" %>

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
                <h3 class="box-title"><strong>Checkin Kamar Kos</strong></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->


            <div class="box-body">
              
                <div class="form-group">
                    <label for="Gedung Kos">Kode Booking </label>
                    <asp:DropDownList ID="DdlGedungList" runat="server" CssClass="form-control" AutoPostBack="true">
                        <asp:ListItem Enabled="true" Text="Select Booking" Value="-1"></asp:ListItem>

                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="Gedung Kos">Kamar </label>
                    <asp:DropDownList ID="ddlKamar" runat="server" CssClass="form-control">
                        <asp:ListItem Enabled="true" Text="Select Kamar" Value="-1"></asp:ListItem>

                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="Gedung Kos">Penghuni </label>
                    <asp:DropDownList ID="ddlPenghuni" runat="server" CssClass="form-control">
                        <asp:ListItem Enabled="true" Text="Select Penghuni" Value="-1"></asp:ListItem>

                    </asp:DropDownList>
                </div>
                <div class="form-group">
                    <label for="KategoriKamar">Tanggal Checkin </label>
                    <asp:TextBox CssClass="form-control" ID="tanggalStay" runat="server" TextMode="Date"></asp:TextBox>

                </div>
                <div class="form-group">
                    <label for="KategoriKamar">Type Angsuran</label>
                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                        <asp:ListItem Enabled="true" Text="Select Type" Value="-1"></asp:ListItem>
                        <asp:ListItem Enabled="true" Text="harian" Value="1"></asp:ListItem>
                        <asp:ListItem Enabled="true" Text="bulanan" Value="2"></asp:ListItem>
                        <asp:ListItem Enabled="true" Text="tiga bulanan" Value="3"></asp:ListItem>
                    </asp:DropDownList>

                </div>
                <div class="form-group">
                    <label for="KategoriKamar">Cost Deal</label>
                    <asp:TextBox CssClass="form-control" ID="cost_deal" runat="server"></asp:TextBox>

                </div>


            </div>
            <!-- /.box-body -->

            <div class="box-footer">
                <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="btnSubmit" Text="Submit" />
            </div>
        </div>
        <div class="box box-primary" style="margin-right: 1px !important">
            <div class="box-header with-border">
                <h3 class="box-title"><strong>Tabel Checkin Kamar</strong></h3>
            </div>
            <%--<div class="box-body">
                    <div id="gridbox" style="width: 100%; height: 100px; background-color: white;" onchange="onUpdate();"></div>
                    <label id="Content" style="display: none"><%: GridContent %></label>
                    <label id="JsonContent" style="display: none" runat="server"></label>
                </div>--%>

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
            myGrid.setHeader("ID Kamar, Gedung,No Kamar,Lantai Kamar, Kategori Kamar, Peruntukan, AC, TV, Tarif Harian, Tarif Bulanan, Tarif Tiga Bulanan, Status Kamar, Keterangan Tambahan");
            myGrid.setColumnIds("idxKamar,gedung_nm,no_kamar,lantai_kmr,kategori_kmr,peruntukan,isAC,isTV,trf_harian,trf_bulanan,trf_tiga_bulanan,stat_kmr,ket");
            myGrid.setInitWidths("*,*,*,*,*,*,*,*,*,*,*,*,*");
            //myGrid.attachHeader("&nbsp,#text_filter,#text_filter,#text_filter;");
            myGrid.enableAutoHeight(true);
            //myGrid.setColumnHidden(2, true);
            myGrid.setColAlign("left,left,left,left,left,left,left,left,left,left");
            myGrid.setColTypes("ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro,ro");
            myGrid.setColSorting("str");
            myGrid.enableAutoHeight(true);
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
                body: '<iframe name=myIframeDelete src="DeleteFile.aspx?rowid=' + ObjectID + '&action=2" width="360px" height="50px" frameBorder="0" runat="server"></iframe>',
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
