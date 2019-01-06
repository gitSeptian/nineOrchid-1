<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="EditMasterKamar.aspx.cs" Inherits="NineOrchid.Pages.Project.EditMasterKamar" %>
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

                            <div class="form-group">
                            <label for="NoKamar">No Kamar</label>
                            <asp:TextBox CssClass="form-control" ID="no_kamar" runat="server"></asp:TextBox>

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
                            <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="Button1" OnClick="Button1_Click" Text="Update" />

                        </div>
                    </div>
                </section>
            </div>
        </section>
    </form>
</asp:Content>
