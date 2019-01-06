<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="DetailKamar.aspx.cs" Inherits="NineOrchid.Pages.Project.DetailKamar" %>

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
                                <label for="Gedung Kos">Gedung Kos</label>
                                <asp:TextBox CssClass="form-control" ID="gedungkos" runat="server"></asp:TextBox>
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
                                <asp:TextBox CssClass="form-control" ID="peruntukan" runat="server"></asp:TextBox>
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
                                <label for="KategoriKamar">Status Kamar</label>
                                <asp:TextBox CssClass="form-control" ID="stat_kamar" runat="server"></asp:TextBox>

                            </div>

                            <div class="form-group">
                                <label for="ket">Keterangan Tambahan</label>
                                <asp:TextBox CssClass="form-control" ID="ket" runat="server" TextMode="multiline" Columns="50" Rows="5"></asp:TextBox>

                            </div>
                            <div class="form-group">
                                <label for="ket">Foto Kamar</label>
                                <asp:Image ID="image1" runat="server" AlternateText="No Upload File Found" Width="100px" Height="100px" CssClass="margin" />
                                <asp:Image ID="image2" runat="server" AlternateText="No Upload File Found" Width="100px" Height="100px" CssClass="margin" />
                                <asp:Image ID="image3" runat="server" AlternateText="No Upload File Found" Width="100px" Height="100px" CssClass="margin" />
                                <asp:Image ID="image4" runat="server" AlternateText="No Upload File Found" Width="100px" Height="100px" CssClass="margin" />
                                <asp:Image ID="image5" runat="server" AlternateText="No Upload File Found" Width="100px" Height="100px" CssClass="margin" />
                            </div>
                            <asp:Button ID="submitKerebat" Text="Back" CssClass="btn pull-right" runat="server" OnClick="submitKerebat_Click"></asp:Button>

                        </div>
                    </div>
                </section>
            </div>
        </section>
    </form>
</asp:Content>
