<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="EditPenghuniMaster.aspx.cs" Inherits="NineOrchid.Pages.Project.EditPenghuniMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentItem" runat="server">
    <form role="form" runat="server" method="post">
        <section class="content">
            <div class="row">
                <section class="col-lg-12">
                    <div class="box box-success">
                        <div class="box-header">Edit Item</div>
                        <div class="box-body">
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
                                    <label for="exampleInputPassword1">Tempat Kerja</label>
                                    <asp:DropDownList runat="server" ID="ddlPerusahaan" EnableTheming="true" CssClass="form-control" Enabled="true">
                                        <asp:ListItem Selected="True" Text="Select Perusahaan"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>

                            <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="Button1" OnClick="Button1_Click" Text="Update" />

                        </div>
                    </div>
                </section>
            </div>
        </section>
    </form>
</asp:Content>
