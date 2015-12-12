function  secBoard(n)
{
for(i=0;i<secTable.cells.length;i++)
secTable.cells[i].className="sec1";
secTable.cells[n].className="sec2";
for(i=0;i<mainTable.tBodies.length;i++)
mainTable.tBodies[i].style.display="none";
mainTable.tBodies[n].style.display="block";
}
function  secBoard2(n)
{
for(i=0;i<secTable2.cells.length;i++)
secTable2.cells[i].className="sec1";
secTable2.cells[n].className="sec2";
for(i=0;i<mainTable2.tBodies.length;i++)
mainTable2.tBodies[i].style.display="none";
mainTable2.tBodies[n].style.display="block";
}
function  secBoard3(n)
{
for(i=0;i<secTable3.cells.length;i++)
secTable3.cells[i].className="sec1";
secTable3.cells[n].className="sec2";
for(i=0;i<mainTable3.tBodies.length;i++)
mainTable3.tBodies[i].style.display="none";
mainTable3.tBodies[n].style.display="block";
}
function mOvr(src, cOvr) 
{if (!src.contains(event.fromElement)) {src.style.cursor = "default";src.bgColor = cOvr;}}
function mOut(src, cOut) 
{if (!src.contains(event.toElement)) {src.style.cursor = "default";src.bgColor = cOut;}}
function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

function rightA()
{

if(demu.scrollLeft<=0)

demu.scrollLeft+=demu25.offsetWidth

else{

demu.scrollLeft--

}
}
function Hright()
{
  ouringht=setInterval(Marquee,speed);

}

function check()
{
  if (document.myform.keyword.value==""||document.myform.keyword.value=="ÇëÊäÈë¹Ø¼ü×Ö")
  {
    alert("ÇëÊäÈë¹Ø¼ü×Ö£¡");
	document.myform.keyword.focus();
    return false;
  }
  return true;  
}


function killErrors() {
return true;
}
window.onerror = killErrors;