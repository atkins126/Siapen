program WebServicePHP;

uses
  ExceptionLog,
  Forms,
  windows,
  ReplicacaoWebService in 'ReplicacaoWebService.pas' {FrmReplicacaoWebService};

{$R *.res}

begin

  if FindWindow( nil, PChar('Replica��o com Web Service PHP - SIAPEN')) = 0 then
  begin
    Application.Initialize;
    Application.Title := 'Replica��o com Web Service PHP - SIAPEN';
    Application.CreateForm(TFrmReplicacaoWebService, FrmReplicacaoWebService);
    Application.Run;
  end;
//  else
//    Application.MessageBox(PChar('O programa est� em funcionamento!'), 'Erro ', MB_OK + MB_ICONERROR);


end.
