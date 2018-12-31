<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="MasterGedung.aspx.cs" Inherits="NineOrchid.Pages.Project.MasterGedung" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #gridbox {
            border: 1px solid #c0c0c0;
            width: 600px;
            height: 350px;
            margin-bottom: 20px;
        }
        /*.form-custom {
            margin-left:20px;
            margin-right:15px;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentItem" runat="server">
    <form role="form" runat="server" class="Content-custom-wrapper">
        <asp:Panel runat="server" ID="panelInfo" Visible="false" CssClass="alert alert-success ">
            <strong>
                <asp:Label ID="infolbl" runat="server"></asp:Label></strong>
        </asp:Panel>


        <div class="box box-primary ">
            <div class="box-header with-border">
                <h3 class="box-title"><strong>Master Gedung Kos</strong></h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->


            <div class="box-body">
                <div class="form-group form-custom">
                    <label for="exampleInputEmail1">Nama Gedung</label>
                    <asp:TextBox CssClass="form-control" ID="nmGedung" runat="server"></asp:TextBox>

                </div>
                <div class="form-group form-custom ">
                    <label for="exampleInputPassword1">Jumlah Lantai</label>
                    <asp:TextBox CssClass="form-control" ID="jmlLantai" runat="server"></asp:TextBox>
                </div>
            </div>
            <!-- /.box-body -->

            <div class="box-footer">
                <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="btnSubmit" OnClick="btnSubmit_Click" Text="Submit" />
            </div>
        </div>
        <div id="gridbox" class="table table-striped" style="width: 100%; height: 100px; background-color: white;" onchange="onUpdate();"></div>
        <label id="Content" style="display: none"><%: GridContent %></label>
        <label id="JsonContent" style="display: none" runat="server"></label>
      
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
                var ObjectID = myGrid.cellByIndex(rIndex, 2).getValue();
                DeleteFile(ObjectID);
            });

            //membuat Grid

            var gridContent = JSON.stringify(content);
            myGrid = new dhtmlXGridObject('gridbox');
            myGrid.setHeader("Nama Gedung,Jumlah Lantai,ID Gedung")
            myGrid.setColumnIds("gedung_nm,jml_lantai,idxGedung");
            myGrid.setInitWidths("*,*,*");
            myGrid.setStyle("height: 40px;background: white;font-family: OpenSans-Regular;font-size: 14px;color: black;line-height: 1.2;font-weight: unset;box-sizing: border-box; border:0px", "", "color:red;", "");
            //myGrid.attachHeader("&nbsp,#text_filter,#text_filter,#text_filter;");
            myGrid.enableAutoHeight(true);
            myGrid.setColumnHidden(2, true);
            myGrid.setColAlign("left,left,left");
            myGrid.setColTypes("ed,ed,ro");
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
            $('#example').dataTable();
        }
        function DeleteFile(ObjectID) {
            w2popup.open({
                title: 'Delete Folder',
                body: '<iframe name=myIframeDelete src="DeleteFile.aspx?rowid=' + ObjectID + '&action=1" width="360px" height="50px" frameBorder="0" runat="server"></iframe>',
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
