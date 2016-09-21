using Uno;
using Uno.Compiler.ExportTargetInterop;
using Android.Base.Wrappers;
using Fuse.Scripting;
using Fuse.Resources;
using Uno.Platform;
using Uno.Threading;
using Uno.UX;

[ForeignInclude(Language.Java, "android.content.Context")]
[ForeignInclude(Language.Java, "android.content.ClipboardManager")]
[ForeignInclude(Language.Java, "android.content.ClipData")]
[ForeignInclude(Language.Java, "android.os.Looper")]
[ForeignInclude(Language.Java, "com.fuse.Activity")]
[TargetSpecificImplementation]
public extern(Android) class Clipboard
{
    public Clipboard() {

    }

    [Foreign(Language.Java)]
    public void SetString(string text)
    @{
      if (Looper.myLooper() == null)
      {
        Looper.prepare();
      }
      Context context = com.fuse.Activity.getRootActivity();
      ClipboardManager clipboard = (ClipboardManager)context.getSystemService(Context.CLIPBOARD_SERVICE);
      ClipData clip = ClipData.newPlainText("app_clipbard", text);
      clipboard.setPrimaryClip(clip);
    @}
}

[TargetSpecificImplementation]
public extern(IOS) class Clipboard
{
    public Clipboard() {

    }

    [Foreign(Language.ObjC)]
    public void SetString(string text)
    @{
      
    @}
}



public extern(Local) class Clipboard
{
  public Clipboard() {

  }

  public void SetString(string text)
  {

  }
}


[UXGlobalModule]
public class ClipboardManager : NativeModule
{

  static readonly ClipboardManager _instance;

  public ClipboardManager()
  {
    debug_log "ClipM!";
    if (_instance != null) return;
    debug_log "ClipNew!";
    _instance = this;
    Resource.SetGlobalKey(this, "ClipboardManager");
    AddMember(new NativeFunction("setText", (NativeCallback)_setText));
  }

  public object _setText(Context c, object[] args)
	{
    debug_log "Set Text: " + args[0].ToString();
    SetText(args[0].ToString());
		return null;
	}

  //static void setText(Context c, object[] args)
  static void SetText(String text)
  {
    debug_log "Received Text: " + text;
    if (defined(ANDROID))
    {
      debug_log "Android Call: " + text;
      var clipb = new Clipboard();
      clipb.SetString(text);
    }
  }

}
