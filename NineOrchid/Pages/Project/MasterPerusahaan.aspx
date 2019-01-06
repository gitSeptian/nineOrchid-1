<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="MasterPerusahaan.aspx.cs" Inherits="NineOrchid.Pages.Project.MasterPerusahaan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentItem" runat="server">
    <section class="content">
        <div class="row">
            <section class="col-lg-12">
                <div class="box box-success">
                    <div class="box-header">Master Perusahaan</div>
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
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Perusahaan</h4>
                    </div>
                    <div class="modal-body">
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
                    <div class="modal-footer">
                        <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="Button2" OnClick="btnSubmit_Click" Text="Submit" />
                    </div>
                </div>

            </div>
        </div>

    </form>




    <script type="text/javascript">
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
            $('#myTable').dataTable(
{
    data: content,

    columns: [

        { title: "Nama", data: "nm_perusahaan", },
        { title: "Alamat", data: "almt_perusahaan" },
        { title: "Kota", data: "kota_perusahaan" },
        { title: "Telp", data: "telp_perusahaan" },
         { title: "", data: "idxPerusahaan", "className": "text-center", mRender: function (id) { return "<button href='#'  class='btn btn-danger btn-xs' data-title='Delete' onClick=DeleteFile(" + id + ") style='margin-left:5px'><span class='glyphicon glyphicon-remove'></button>"; } }
    ]
}

    );

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
        function AddData() {
            $("#myModal").modal("show");
        }
    </script>
</asp:Content>
