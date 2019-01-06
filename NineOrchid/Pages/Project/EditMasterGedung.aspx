<%@ Page Title="" Language="C#" MasterPageFile="~/NineOrchid.Master" AutoEventWireup="true" CodeBehind="EditMasterGedung.aspx.cs" Inherits="NineOrchid.Pages.Project.EditMasterGedung" %>

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
                                <label for="exampleInputEmail1">Nama Gedung</label>
                                <asp:TextBox CssClass="form-control" ID="nmGedung" runat="server" EnableViewState="false"></asp:TextBox>

                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Jumlah Lantai</label>
                                <asp:TextBox CssClass="form-control" ID="jmlLantai" runat="server" EnableViewState="false"></asp:TextBox>
                            </div>
                            <asp:Button runat="server" CssClass="btn btn-primary pull-right" ID="Button1" OnClick="Button1_Click" Text="Update" />

                        </div>
                    </div>
                </section>
            </div>
        </section>
    </form>
</asp:Content>
