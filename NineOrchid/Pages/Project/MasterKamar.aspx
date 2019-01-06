<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="MasterKamar.aspx.cs" Inherits="NineOrchid.Pages.Project.MasterKamar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .margin {
            margin-bottom: 10px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentItem" runat="server">
    <script>
        function AddFoto(action) {
            if (action == 1) {
                $("#ContentItem_FileUpload1").css("visibility", "visible");
                $("#ContentItem_Button1").css("visibility", "visible");
            }
        }
    </script>
    <section class="content">
        <div class="row">
            <section class="col-lg-12">
                <div class="box box-success">
                    <div class="box-header">Master Gedung</div>
                    <div class="box-body">

                        <label id="Content" style="display: none"><%: GridContent %></label>
                        <label id="Label1" style="display: none" runat="server"></label>
                        <button class="btn btn-info pull-left btn-md" onclick="AddData()" style="margin-bottom: 15px">Add New</button>
                        <table id="myTable" class="table table-responsive table-bordered table-striped">

                            <thead class="panel panel-default">
                            </thead>

                            <tbody class="">
                            </tbody>
                        </table>

                    </div>
                </div>
            </section>
        </div>
    </section>
    <form role="form" runat="server">
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Kamar</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="NoKamar">No Kamar</label>
                            <asp:TextBox CssClass="form-control" ID="no_kamar" runat="server"></asp:TextBox>

                        </div>
                        <div class="form-group">
                            <label for="Gedung Kos">Gedung Kos</label>
                            <asp:DropDownList ID="DdlGedungList" runat="server" CssClass="form-control">
                                <asp:ListItem Enabled="true" Text="Select Gedung" Value="-1"></asp:ListItem>

                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="LantaiKamar">Lantai Kamar</label>
                            <asp:TextBox CssClass="form-control" ID="lantai_kmr" runat="server"></asp:TextBox>

                        </div>
                        <div class="form-group">
                            <label for="KategoriKamar">Kategori Kamar</label>
                            <asp:TextBox CssClass="form-control" ID="KategoriKamar" runat="server"></asp:TextBox>

                        </div>
                        <div class="form-group">
                            <label for="KategoriKamar">Peruntukan</label>
                            <asp:DropDownList ID="peruntukanddl" runat="server" CssClass="form-control">
                                <asp:ListItem Enabled="true" Text="Select kategori" Value="-1"></asp:ListItem>
                                <asp:ListItem Text="Wanita/Pasutri" Value="3"></asp:ListItem>
                                <asp:ListItem Text="Wanita" Value="2"></asp:ListItem>
                                <asp:ListItem Text="Pria" Value="1"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label for="isAC">Ada AC</label>
                            <asp:CheckBox ID="CheckBoxAC" runat="server" />
                            <label for="isTV" style="margin-left: 20px">Ada TV</label>
                            <asp:CheckBox ID="CheckBoxTV" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="KategoriKamar">Tarif Kamar Harian</label>
                            <asp:TextBox CssClass="form-control marginleft" ID="trf_harian" runat="server"></asp:TextBox>

                        </div>
                        <div class="form-group">
                            <label for="KategoriKamar">Tarif Kamar Bulanan</label>
                            <asp:TextBox CssClass="form-control" ID="trf_bulanan" runat="server"></asp:TextBox>

                        </div>
                        <div class="form-group">
                            <label for="KategoriKamar">Tarif Kamar Tiga Bulanan</label>
                            <asp:TextBox CssClass="form-control" ID="trf_tiga_bulanan" runat="server"></asp:TextBox>

                        </div>
                        <div class="form-group">
                            <label for="ket">Keterangan Tambahan</label>
                            <asp:TextBox CssClass="form-control" ID="ket" runat="server" TextMode="multiline" Columns="50" Rows="5"></asp:TextBox>

                        </div>
                        <div class="form-group">
                            <label for="ket">Foto Kos</label><br />
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                            <asp:FileUpload ID="FileUpload2" runat="server" />
                            <asp:FileUpload ID="FileUpload3" runat="server" />
                            <asp:FileUpload ID="FileUpload4" runat="server" />
                            <asp:FileUpload ID="FileUpload5" runat="server" />


                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="Button1" OnClick="btnSubmit_Click" Text="Submit" />
                    </div>
                </div>

            </div>
        </div>

    </form>


    <asp:Panel runat="server" ID="panelInfo" Visible="false" CssClass="alert alert-success">
        <strong>
            <asp:Label ID="infolbl" runat="server"></asp:Label></strong>
    </asp:Panel>


    <script type="text/javascript">
        function AddData() {
            $("#myModal").modal("show");
        }
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

                columns: [

                    { title: "ID", data: "idxKamar", },
                    { title: "Letak Kamar", data: "gedung_nm" },
                    { title: "No Kamar", data: "no_kamar" },
                     { title: "Peruntukan", data: "peruntukan" },
                      { title: "Status Kamar", data: "stat_kmr" },
                      { title: "Keterangan", data: "ket" },
                      { title: "Details", data: "idxKamar", "className": "text-center", mRender: function (id) { var param = id.toString(); return "<a class='btn btn-success btn-xs' href='DetailKamar.aspx?rowid=" + param + "' role='button' target='_blank'><span class='glyphicon glyphicon-list-alt'></a>"; } },
                         { title: "", data: "idxKamar", "className": "text-center", mRender: function (id) { var param = id.toString(); return "<a class='btn btn-info btn-xs' href='EditMasterKamar.aspx?rowid=" + param + "' role='button' target='_blank'><span class='glyphicon glyphicon-pencil'></a><button href='#'  class='btn btn-danger btn-xs' data-title='Delete' onClick=DeleteFile('" + param + "') style='margin-left:5px'><span class='glyphicon glyphicon-remove'></button>"; } }
                ]
            }

                );
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
