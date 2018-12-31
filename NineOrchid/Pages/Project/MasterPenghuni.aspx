<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="MasterPenghuni.aspx.cs" Inherits="NineOrchid.Pages.Project.MasterPenghuni" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentItem" runat="server">
    <form role="form" runat="server" style="padding: 20px 20px 1px 35px">
        <asp:Panel runat="server" ID="panelInfo" Visible="false" CssClass="alert alert-success">
            <strong>
                <asp:Label ID="infolbl" runat="server"></asp:Label></strong>
        </asp:Panel>


        <div class="box box-primary">
            <div class="box-header with-border">
                <h4 class="box-title pull-left">Data Diri</h4>
                <a class="btn btn-sm pull-right" data-toggle="collapse" data-target="#collapse1"><i class="fa fa-plus "></i></a>
            </div>
            <div class="box-body panel-collapse collapse in " id="collapse1">
                <div class="form-row">
                    <div class="col">
                        <label for="exampleInputEmail1">Nama </label>
                        <asp:TextBox CssClass="form-control" ID="nama" runat="server"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label for="exampleInputPassword1">Agama</label>
                        <asp:TextBox CssClass="form-control" ID="agama" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col">
                        <label for="exampleInputPassword1">Tempat Lahir</label>
                        <asp:TextBox CssClass="form-control" ID="TempatLahir" runat="server"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label for="exampleInputPassword1">Tanggal Lahir</label>
                        <!-- Date input -->
                        <asp:TextBox CssClass="form-control" ID="tanggalLahir" runat="server" TextMode="Date"></asp:TextBox>
                        <%--      <input class="form-control" id="date" name="date" placeholder="MM/DD/YYY" type="text" />--%>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col">
                        <label for="exampleInputPassword1">Type ID Card</label>
                        <asp:DropDownList runat="server" ID="ddlIDCard" EnableTheming="true" CssClass="form-control">
                            <asp:ListItem Selected="True" Text="Select ID"></asp:ListItem>
                            <asp:ListItem Text="KTP" Value="1"></asp:ListItem>
                            <asp:ListItem Text="SIM" Value="2"></asp:ListItem>
                            <asp:ListItem Text="NPWP" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col">
                        <label for="exampleInputPassword1">No ID Card</label>
                        <asp:TextBox CssClass="form-control" ID="no_id" runat="server"></asp:TextBox>
                    </div>

                </div>
                <div class="form-row">
                    <div class="col">
                        <label for="exampleInputPassword1">No HP</label>
                        <asp:TextBox CssClass="form-control" ID="noHP" runat="server"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label for="exampleInputPassword1">email</label>
                        <asp:TextBox CssClass="form-control" ID="email" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col">
                          <label for="exampleInputPassword1">Alamat</label>
                    <asp:TextBox CssClass="form-control" ID="alamat_asal" runat="server" TextMode="MultiLine" Rows="2"></asp:TextBox>
                    </div>
                    <div class="col">
                          <label for="exampleInputPassword1">Pekerjaan</label>
                    <asp:TextBox CssClass="form-control" ID="pekerjaan" runat="server"></asp:TextBox>
                    </div>
                  

                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Upload Foto Penghuni</label><br />
                    <asp:FileUpload ID="FileUploadPenghuni" runat="server" />
                    <asp:Button runat="server" ID="UploadFotoPenghuni" Text="Upload" />
                    <%--<asp:Label runat="server" ID="StatusLabel" Text="Upload status: " />--%>
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Upload Foto ID</label><br />
                    <asp:FileUpload ID="FileUpladId" runat="server" />
                    <asp:Button runat="server" ID="UploadFotoIDCard" Text="Upload" />
                    <%--<asp:Label runat="server" ID="StatusLabel" Text="Upload status: " />--%>
                </div>
            </div>
            <div class="panel-footer">
            </div>
        </div>
        <div class="box box-primary">
            <div class="box-header with-border">
                <h4 class="box-title pull-left">Data Perusahaan</h4>
                <a class="btn btn-sm pull-right" data-toggle="collapse" data-target="#collapse2"><i class="fa fa-plus "></i></a>
            </div>
            <div class="box-body panel-collapse collapse in" id="collapse2">
                <div class="form-row">
                    <div class="col">
                        <label for="exampleInputPassword1">Perusahaan sudah terdaftar di Master Data?</label>
                        <asp:CheckBox ID="checkPerusahaan" runat="server" Checked="false" EnableTheming="true" CssClass="toogle" OnCheckedChanged="checkPerusahaan_CheckedChanged" AutoPostBack="true" />
                    </div>
                    <div class="col">
                        <asp:DropDownList runat="server" ID="ddlPerusahaan" EnableTheming="true" CssClass="form-control" Enabled="false" AutoPostBack="true" OnSelectedIndexChanged="ddlPerusahaan_SelectedIndexChanged">
                            <asp:ListItem Selected="True" Text="Select Perusahaan"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <div class="form-row">
                    <div class="col">
                        <label for="exampleInputPassword1">Nama Perusahaan</label>
                        <asp:TextBox CssClass="form-control" ID="nmperusahaan" runat="server"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label for="exampleInputPassword1">Kota Perusahaan</label>
                        <asp:TextBox CssClass="form-control" ID="kotaperusahaan" runat="server"></asp:TextBox>
                    </div>
                    <div class="col">
                        <label for="exampleInputPassword1">No Telp Perusahaan</label>
                        <asp:TextBox CssClass="form-control" ID="telpPerusahaan" runat="server"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label for="exampleInputPassword1">Alamat</label>
                    <asp:TextBox CssClass="form-control" ID="AlamatPerusahaan" runat="server" TextMode="MultiLine" Columns="20" Rows="3"></asp:TextBox>

                </div>
            </div>
            <div class="panel-footer">
            </div>
        </div>
<%--        <div class="box box-primary" runat="server" id="KerabatField">
            <div class="box-header with-border">
                <h4 class="box-title pull-left">Data Kerabat</h4>
                <a class="btn btn-sm pull-right" data-toggle="collapse" data-target="#collapse3"><i class="fa fa-plus "></i></a>
            </div>
            <div class="box-body panel-collapse collapse" id="collapse3">
                <div class="form-parent">
                    <div class="clonedInput" id="clonedForm">

                        <div class="form-row">
                            <div class="col">
                                <label for="exampleInputPassword1">Nama</label>
                                <asp:TextBox CssClass="form-control" ID="nmKerabat" runat="server"></asp:TextBox>
                            </div>
                            <div class="col">
                                <label for="exampleInputPassword1">No Telp</label>
                                <asp:TextBox CssClass="form-control" ID="TextBox3" runat="server"></asp:TextBox>
                            </div>

                        </div>
                        <div class="form-row">
                            <div class="col">
                                <label for="exampleInputPassword1">Alamat</label>
                                <asp:TextBox CssClass="form-control" ID="TextBox5" runat="server" TextMode="MultiLine" Columns="20" Rows="3"></asp:TextBox>
                            </div>
                            <div class="col">
                                <label for="exampleInputPassword1">Hubungan</label>
                                <asp:DropDownList runat="server" ID="ddlHub" EnableTheming="true" CssClass="form-control">
                                    <asp:ListItem Selected="True" Text="Select Hubungan"></asp:ListItem>
                                    <asp:ListItem Text="Pengikut" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Keluarga" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Lainnya" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                    </div>
                </div>
                <div class="panel-footer">
                    <asp:Button runat="server" CssClass="btn btn-success pull-right clone" ID="btnAdd" Text="Add" OnClientClick="return false;" />
                </div>
            </div>--%>

<%--        </div>--%>


        <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="btnSubmit" OnClick="btnSubmit_Click" Text="Submit" />

         <div class="box box-primary" style="margin-right:1px !important;margin-top:80px;">
                <div class="box-header with-border">
                    <h3 class="box-title"><strong>Tabel Penghuni Kos</strong></h3>
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
        $('#ContentItem_btnAdd').click(function () {
            var clone = $('#clonedForm').clone();
            $('.form-parent').append(clone);
        });
        //var regex = /^(.+?)(\d+)$/i;
        //var cloneIndex = $(".clonedInput").length;
        //function clone() {
        //    var a = $(this).parents("#clonedInput1").clone()
        //        .appendTo("body")
        //        .attr("id", "clonedInput" + cloneIndex)
        //        .find("*")
        //        .each(function () {
        //            var id = this.id || "";
        //            var match = id.match(regex) || [];
        //            if (match.length == 3) {
        //                this.id = match[1] + (cloneIndex);
        //            }
        //        })
        //        .on('click', 'button.clone', clone)
        //        .on('click', 'button.remove', remove);
        //    cloneIndex++;
        //}
        //function remove() {
        //    $(this).parents(".clonedInput").remove();
        //}
        //$("button.clone").on("click", clone);

        //$("button.remove").on("click", remove);

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
            myGrid.setHeader("ID,Nama,TTL,No Telp, Detail");
            myGrid.setColumnIds("idxPerusahaan,nm_penghuni,TTL,no_hp,Details");
            myGrid.setInitWidths("*,*,*,*,*");
            //myGrid.attachHeader("&nbsp,#text_filter,#text_filter,#text_filter;");
            myGrid.enableAutoHeight(true);
            myGrid.setColumnHidden(0, true);
            myGrid.setColAlign("left,left,left,left,left");
            myGrid.setColTypes("ro,ro,ro,ro,link");
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

