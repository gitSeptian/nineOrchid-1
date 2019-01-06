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
    <section class="content">
        <div class="row">
            <section class="col-lg-12">
                <div class="box box-success">
                    <div class="box-header">Master Gedung</div>
                    <div class="box-body">

                        <label id="Content" style="display: none"><%: GridContent %></label>
                        <label id="JsonContent" style="display: none" runat="server"></label>
                        <button class="btn btn-info pull-left btn-md" onclick="AddData()" style="margin-bottom: 15px">Add New</button>
                        <table id="myTable" class="table table-responsive table-bordered table-striped">

                            <thead class="panel panel-default">
                                <tr>
                                    <th></th>
                                    <th>ID</th>
                                    <th>NAMA GEDUNG</th>
                                    <th>LANTAI</th>
                                </tr>

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
                        <h4 class="modal-title">Add New Gedung</h4>
                    </div>
                    <div class="modal-body">

                        <div class="form-group form-custom">
                            <label for="exampleInputEmail1">Nama Gedung</label>
                            <asp:TextBox CssClass="form-control" ID="nmGedung" runat="server"></asp:TextBox>

                        </div>
                        <div class="form-group form-custom">
                            <label for="exampleInputPassword1">Jumlah Lantai</label>
                            <asp:TextBox CssClass="form-control" ID="jmlLantai" runat="server"></asp:TextBox>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="Button1" OnClick="btnSubmit_Click" Text="Submit" />
                    </div>
                </div>

            </div>
        </div>

    </form>
    <%--    <div id="gridbox" class="table table-striped" style="width: 100%; height: 100px; background-color: white;" onchange="onUpdate();"></div>--%>
    <%-- <form role="form" runat="server" class="Content-custom-wrapper">
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
            <table id="myTable" class="table table-responsive">
                <thead>
                    <tr>
                        <th>1</th>
                        <th>2</th>
                        <th>3</th>
                        <th>4</th>
                    </tr>

                </thead>
                <tbody>
                    <tr>
                        <td>a</td>
                        <td>b</td>
                        <td>c</td>
                        <td>d</td>
                    </tr>
                </tbody>
            </table>

            <div class="box-body">
                <div class="row"></div>
            </div>
            <!-- /.box-body -->

            <div class="box-footer">
                
            </div>
        </div>
        <div id="gridbox" class="table table-striped" style="width: 100%; height: 100px; background-color: white;" onchange="onUpdate();"></div>
        <label id="Content" style="display: none"><%: GridContent %></label>
        <label id="JsonContent" style="display: none" runat="server"></label>

         

    </form>
    --%>
    <script type="text/javascript">
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

                    { title: "ID", data: "idxGedung", },
                    { title: "NAMA GEDUNG", data: "gedung_nm" },
                    { title: "LANTAI", data: "jml_lantai" },
                     { title: "", data: "idxGedung", "className": "text-center", mRender: function (id) { return "<a class='btn btn-info btn-xs' href='EditMasterGedung.aspx?rowid="+id+"' role='button'><span class='glyphicon glyphicon-pencil'></a><button href='#'  class='btn btn-danger btn-xs' data-title='Delete' onClick=DeleteFile(" + id + ") style='margin-left:5px'><span class='glyphicon glyphicon-remove'></button>"; } }
                ]
            }

                );
        }

        function editData(id) {
            w2popup.open({
                title: 'Delete Folder',
                body: '<iframe name=myIframeDelete src="EditMasterGdung.aspx?rowid=' + id + '&action=1" width="360px" height="50px" frameBorder="0" runat="server"></iframe>',
                width: 600,
                height: 500,
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

    <!-- Modal -->

</asp:Content>
