unit CadastroEventos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ModeloCadastro, FMTBcd, DB, DBClient, Provider, SqlExpr,
  ImgList, ComCtrls, Grids, DBGrids, StdCtrls, DBCtrls, ToolWin, ExtCtrls,
  Mask, jpeg, Lib;

type
  TFrmCadastroEventos = class(TFrmModeloCadastro)
    Label2: TLabel;
    DBEditcodigo: TDBEdit;
    Label3: TLabel;
    DBEdtDescricao: TDBEdit;
    Label4: TLabel;
    DBEdtCodigoEvento: TDBEdit;
    DBRgSubEvento: TDBRadioGroup;
    Label5: TLabel;
    DBCbTipoEvento: TDBComboBox;
    procedure NovoClick(Sender: TObject);
    procedure SalvarClick(Sender: TObject);
    procedure DsCadastroDataChange(Sender: TObject; Field: TField);
    procedure PageControlModeloCadastroChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCadastroEventos: TFrmCadastroEventos;

implementation

{$R *.dfm}

procedure TFrmCadastroEventos.NovoClick(Sender: TObject);
begin
  inherited;
  DBEdtCodigoEvento.SetFocus;
  DBCbTipoEvento.ItemIndex := 0;
  DBRgSubEvento.ItemIndex := 1;
end;

procedure TFrmCadastroEventos.SalvarClick(Sender: TObject);
begin

  if Trim(DBEdtCodigoEvento.Text) = '' then
  begin
    ShowMessage('O campo C�digo n�o pode ser vazio!');

    if DBEdtCodigoEvento.CanFocus then
      DBEdtCodigoEvento.SetFocus;

    Exit;
  end;

  if Trim(DBEdtDescricao.Text) = '' then
  begin
    ShowMessage('O campo Descri��o do Evento n�o pode ser vazio!');

    if DBEdtDescricao.CanFocus then
      DBEdtDescricao.SetFocus;

    Exit;
  end;

  if DBCbTipoEvento.ItemIndex = -1 then
  begin
    ShowMessage('O campo Tipo de Evento n�o pode ser vazio!');

    if DBCbTipoEvento.CanFocus then
      DBCbTipoEvento.SetFocus;

    Exit;
  end;

  if DBRgSubEvento.ItemIndex = -1 then
    DsCadastro.DataSet.FieldByName('SUB_EVENTOS').AsString := 'N';

  if DBCbTipoEvento.ItemIndex = 0 then
  begin
    DsCadastro.DataSet.FieldByName('TIPO_EVENTO').AsString := '1';
  end;

  if DBCbTipoEvento.ItemIndex = 1 then
  begin
    DsCadastro.DataSet.FieldByName('TIPO_EVENTO').AsString := '2';
  end;

  inherited;
end;

procedure TFrmCadastroEventos.DsCadastroDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  if DsCadastro.DataSet.FieldByName('TIPO_EVENTO').AsString = '1' then
  begin
    DBCbTipoEvento.ItemIndex := 0;
  end;

  if DsCadastro.DataSet.FieldByName('TIPO_EVENTO').AsString = '2' then
  begin
    DBCbTipoEvento.ItemIndex := 1;
  end;

  {Verifica as permiss�es que o usu�rio possui para esta tela
  e habilita ou n�o os respectivos bot�es.
  Estas verifica��es devem ser colocadas no final do evento FormCreate e
  no final do evento OnDataChange do DsCadastro de cada tela.
  Obs: atentar para mudar a permiss�o referente � tela nas verifica��es abaixo.
  Ex. ContemValor('I', PERMISSAO_CONFERE).}

  if not ContemValor('I', PERMISSAO_EVENTOS)
    and not ContemValor('E', PERMISSAO_EVENTOS)
    and not ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Novo.Visible := False;
    Editar.Visible := False;
    Excluir.Visible := False;
    Salvar.Visible := False;
  end;

  if ContemValor('I', PERMISSAO_EVENTOS)
    and not ContemValor('E', PERMISSAO_EVENTOS)
    and not ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Editar.Visible := False;
    Excluir.Visible := False;
    if not Salvar.Visible then
      Salvar.Visible := False;
    if not Salvar.Enabled then
      Salvar.Visible := False;
  end;

  if ContemValor('I', PERMISSAO_EVENTOS)
    and ContemValor('E', PERMISSAO_EVENTOS)
    and not ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Excluir.Visible := False;
  end;

  if not ContemValor('I', PERMISSAO_EVENTOS)
    and ContemValor('E', PERMISSAO_EVENTOS)
    and ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Novo.Visible := False;
  end;

  if ContemValor('I', PERMISSAO_EVENTOS)
    and not ContemValor('E', PERMISSAO_EVENTOS)
    and ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Editar.Visible := False;
    if not Salvar.Visible then
      Salvar.Visible := False;
    if not Salvar.Enabled then
      Salvar.Visible := False;
  end;

  if not ContemValor('I', PERMISSAO_EVENTOS)
    and not ContemValor('E', PERMISSAO_EVENTOS)
    and ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Novo.Visible := False;
    Editar.Visible := False;
    if not Salvar.Visible then
      Salvar.Visible := False;
    if not Salvar.Enabled then
      Salvar.Visible := False;
  end;

  if not ContemValor('I', PERMISSAO_EVENTOS)
    and ContemValor('E', PERMISSAO_EVENTOS)
    and not ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Novo.Visible := False;
    Excluir.Visible := False;
  end;

end;

procedure TFrmCadastroEventos.PageControlModeloCadastroChange(
  Sender: TObject);
begin
  inherited;
  if PageControlModeloCadastro.ActivePageIndex = 1 then
  begin
    DBGridConsulta.SelectedIndex := 2;
  end;
end;

procedure TFrmCadastroEventos.FormCreate(Sender: TObject);
begin
  inherited;

  {Verifica as permiss�es que o usu�rio possui para esta tela
  e habilita ou n�o os respectivos bot�es.
  Estas verifica��es devem ser colocadas no final do evento FormCreate e
  no final do evento OnDataChange do DsCadastro de cada tela.
  Obs: atentar para mudar a permiss�o referente � tela nas verifica��es abaixo.
  Ex. ContemValor('I', PERMISSAO_CONFERE).}

  if not ContemValor('I', PERMISSAO_EVENTOS)
    and not ContemValor('E', PERMISSAO_EVENTOS)
    and not ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Novo.Visible := False;
    Editar.Visible := False;
    Excluir.Visible := False;
    Salvar.Visible := False;
  end;

  if ContemValor('I', PERMISSAO_EVENTOS)
    and not ContemValor('E', PERMISSAO_EVENTOS)
    and not ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Editar.Visible := False;
    Excluir.Visible := False;
    if not Salvar.Visible then
      Salvar.Visible := False;
    if not Salvar.Enabled then
      Salvar.Visible := False;
  end;

  if ContemValor('I', PERMISSAO_EVENTOS)
    and ContemValor('E', PERMISSAO_EVENTOS)
    and not ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Excluir.Visible := False;
  end;

  if not ContemValor('I', PERMISSAO_EVENTOS)
    and ContemValor('E', PERMISSAO_EVENTOS)
    and ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Novo.Visible := False;
  end;

  if ContemValor('I', PERMISSAO_EVENTOS)
    and not ContemValor('E', PERMISSAO_EVENTOS)
    and ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Editar.Visible := False;
    if not Salvar.Visible then
      Salvar.Visible := False;
    if not Salvar.Enabled then
      Salvar.Visible := False;
  end;

  if not ContemValor('I', PERMISSAO_EVENTOS)
    and not ContemValor('E', PERMISSAO_EVENTOS)
    and ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Novo.Visible := False;
    Editar.Visible := False;
    if not Salvar.Visible then
      Salvar.Visible := False;
    if not Salvar.Enabled then
      Salvar.Visible := False;
  end;

  if not ContemValor('I', PERMISSAO_EVENTOS)
    and ContemValor('E', PERMISSAO_EVENTOS)
    and not ContemValor('D', PERMISSAO_EVENTOS) then
  begin
    Novo.Visible := False;
    Excluir.Visible := False;
  end;

end;

end.

