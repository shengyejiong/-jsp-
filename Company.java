package bean;

public class Company {
    private String desname;
    private String macname;
    private String maccode;
    private String macvary;
    private String mactype;
    private String installtime;
    private String macstate;

    public Company(){};
    public Company(String desname,String macname,String maccode,String macvary,String mactype,String installtime,String macstate){
        this.desname = desname;
        this.macname = macname;
        this.maccode = maccode;
        this.macvary = macvary;
        this.mactype = mactype;
        this.installtime = installtime;
        this.macstate = macstate;
    }

    public String getDesname(){
        return desname;
    }
    public void setDesname(String desname){
        this.desname = desname;
    }
    public String getMacname(){
        return macname;
    }
    public void setMacname(String macname){
        this.macname = macname;
    }
    public String getMaccode(){
        return maccode;
    }
    public void setMaccode(String maccode){
        this.maccode = maccode;
    }
    public String getMacvary(){
        return macvary;
    }
    public void setMacvary(String macvary){
        this.macvary = macvary;
    }
    public String getMactype(){
        return mactype;
    }
    public void setMactype(String mactype){
        this.mactype = mactype;
    }
    public String getInstalltime(){
        return installtime;
    }
    public void setInstalltime(String installtime){
        this.installtime = installtime;
    }
    public String getMacstate(){
        return macstate;
    }
    public void setMacstate(String macstate){
        this.macstate = macstate;
    }

}
