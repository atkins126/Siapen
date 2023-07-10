library SKINDLL;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SkinUnit in 'SkinUnit.pas';


{$R SKIN.res}

exports
  InitSkin, //��ʼ������ initialize function
  UnLoadAll, //��β����  release function
  SetActive,  //������߲�����  active or not
  SetSkinFile, //���� SKIN      set skin for your form
  Add3rdControl; //���ӵ������ؼ�  add 3rd components eg. raize,elib etc.

{
  ʹ�÷�����

  �� Form ����ʱ���� initskin(handle), initskin ֻ�����һ��
  �� initskin ֮������� show ʱ�� SetSkinFile ����ȱʡ�� skin

  ��θ��� skin :
  ����� initskin �󣬸�����Ҫ�� SetSkinFile����������Ҫ�� skin
  Ҳ���Դ��� skin �б��пͻ��Լ�ѡ��

  �����β��
  �� Query form close ʱ���� UnLoadAll �ͷŵ��� initskin ������ skin

  Usage:
  Call initskin function when Form foundation and transfers form.handle as paramter to initskin,
  initskin function have use only one time,
  then set default skiin by seskinfile function when the form showing or creating.

  After  completes initskin, according to needs change or replaces skin by SetSkinFile funciton which needs also may found skin tabulates,
  how has customer own chooses

  Concludes:
  When form Query close transfers UnLoadAll to bleeds off skin which founds by initskin function
}
begin

end.
