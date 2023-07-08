{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2015 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DBXFirebirdReadOnlyMetaData;

interface

uses
  Data.DBXMetaDataReader,
  Data.DBXMetaDataCommandFactory;

type
  TDBXFirebirdMetaDataCommandFactory = class(TDBXMetaDataCommandFactory)
  public
    function CreateMetaDataReader: TDBXMetaDataReader; override;
  end;

implementation

uses
  Data.DBXFirebirdMetaDataReader;

function TDBXFirebirdMetaDataCommandFactory.CreateMetaDataReader: TDBXMetaDataReader;
begin
  Result := TDBXFirebirdMetaDataReader.Create;
end;

initialization
  TDBXMetaDataCommandFactory.RegisterMetaDataCommandFactory(TDBXFirebirdMetaDataCommandFactory);
finalization
  TDBXMetaDataCommandFactory.UnRegisterMetaDataCommandFactory(TDBXFirebirdMetaDataCommandFactory);
end.
