<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="MasterPenghuni.aspx.cs" Inherits="NineOrchid.Pages.Project.MasterPenghuni" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentItem" runat="server">
    <section class="content">
        <div class="row">
            <section class="col-lg-12">
                <div class="box box-success">
                    <div class="box-header">Master Penghuni</div>
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
        <asp:Panel runat="server" ID="panelInfo" Visible="false" CssClass="alert alert-success">
            <strong><asp:Label ID="infolbl" runat="server"></asp:Label></strong>
        </asp:Panel>
        <div id="myModal" class="modal fade" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Add New Penghuni</h4>
                    </div>
                    <div class="modal-body">
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

                            <%--<asp:Label runat="server" ID="StatusLabel" Text="Upload status: " />--%>
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Upload Foto ID</label><br />
                            <asp:FileUpload ID="FileUpladId" runat="server" />

                            <%--<asp:Label runat="server" ID="StatusLabel" Text="Upload status: " />--%>
                        </div>

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
                        <div class="modal-footer">
                            <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="Button1" OnClick="btnSubmit_Click" Text="Submit" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>

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


    <%--<asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="btnSubmit" OnClick="btnSubmit_Click" Text="Submit" />

    <div class="box box-primary" style="margin-right: 1px !important; margin-top: 80px;">
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
    </form>--%>

    <script type="text/javascript">
        function AddData() {
            $("#myModal").modal("show");
        }
        $('#ContentItem_btnAdd').click(function () {
            var clone = $('#clonedForm').clone();
            $('.form-parent').append(clone);
        });

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

        { title: "Nama", data: "nm_penghuni" },
        { title: "TTL", data: "TTL" },
         { title: "No Telp", data: "no_hp" },
          { title: "Pekerjaan", data: "pekerjaan" },
          { title: "Details", data: "idxPenghuni", "className": "text-center", mRender: function (id) { var param = id.toString(); return "<a class='btn btn-success btn-xs' href='DetailPenghuni.aspx?ID=" +id+ "' role='button' target='_blank'><span class='glyphicon glyphicon-list-alt'></a>"; } },
          { title: "", data: "idxPenghuni", "className": "text-center", mRender: function (id) { var param = id.toString(); return "<a class='btn btn-info btn-xs' href='EditPenghuniMaster.aspx?rowid=" + id + "' role='button' target='_blank'><span class='glyphicon glyphicon-pencil'></a><button href='#'  class='btn btn-danger btn-xs' data-title='Delete' onClick=DeleteFile(" + id + ") style='margin-left:5px'><span class='glyphicon glyphicon-remove'></button>"; } }
    ]
}

    );
        }
        function DeleteFile(ObjectID) {
            w2popup.open({
                title: 'Delete Folder',
                body: '<iframe name=myIframeDelete src="DeleteFile.aspx?rowid=' + ObjectID + '&action=5" width="360px" height="50px" frameBorder="0" runat="server"></iframe>',
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

