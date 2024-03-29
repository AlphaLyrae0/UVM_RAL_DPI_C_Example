#include <stdio.h>
#include <string.h>
#include <iostream>
#include <string>
#include <sstream>
#include <iomanip>

using namespace std;

#include "dpi.h"
//extern "C" void ral_reg_write (const char *, int );
//extern "C" void ral_reg_set   (const char *, int );
//extern "C" void ral_fld_set   (const char *, int );
//extern "C" void ral_reg_update(const char *);
//
//extern "C" void ral_reg_read  (const char *, int *);
//extern "C" void ral_reg_mirror(const char *);
//extern "C" int  ral_reg_get   (const char *);
//extern "C" int  ral_fld_get   (const char *);



void reg_read_print(string regname)
{
  int val;
  ostringstream ss;
  string msg;
  ral_reg_read(regname.c_str(), &val);
  ss << "0x" << setfill('0') << setw(8) << hex << uppercase << val;
  msg = "#### REGISTER READ VALUE : " + regname + " = " + ss.str(); //to_string(val);
  sv_print(msg.c_str());
}

void ral_reg_print(string regname)
{
  ostringstream ss;
  string msg;
  ss << "0x" << setfill('0') << setw(8) << hex << uppercase << ral_reg_get(regname.c_str());
  msg = regname + " : " + ss.str(); //to_string(ral_reg_get(regname.c_str()));
  sv_print(msg.c_str());
}

void ral_fld_print(string fldname)
{
  string msg;
  msg = fldname + " : " + to_string(ral_fld_get(fldname.c_str()));
  sv_print(msg.c_str());
}

void CONFIG_AAA_field_access(void)
{
  sv_print("");
  sv_print("-------------------------------------");
  sv_print("  CONFIG_AAA Read Access");
  sv_print("-------------------------------------");
  sv_print("CONFIG_AAA Before Read");
  ral_fld_print ("CONFIG_AAA.param_0");
  ral_fld_print ("CONFIG_AAA.param_1");
  ral_fld_print ("CONFIG_AAA.param_2");
  ral_fld_print ("CONFIG_AAA.param_3");
  ral_fld_print ("CONFIG_AAA.param_4");
  ral_fld_print ("CONFIG_AAA.param_5");
  ral_fld_print ("CONFIG_AAA.param_6");
  ral_fld_print ("CONFIG_AAA.param_7");
  reg_read_print("CONFIG_AAA");
  sv_print("CONFIG_AAA After Read");
  ral_fld_print ("CONFIG_AAA.param_0");
  ral_fld_print ("CONFIG_AAA.param_1");
  ral_fld_print ("CONFIG_AAA.param_2");
  ral_fld_print ("CONFIG_AAA.param_3");
  ral_fld_print ("CONFIG_AAA.param_4");
  ral_fld_print ("CONFIG_AAA.param_5");
  ral_fld_print ("CONFIG_AAA.param_6");
  ral_fld_print ("CONFIG_AAA.param_7");

  //---------------- CONFIG_AAA Field Write ------------
  sv_print("");
  sv_print("-------------------------------------");
  sv_print("  CONFIG_AAA Write Access");
  sv_print("-------------------------------------");
  ral_fld_set   ("CONFIG_AAA.param_0" ,255); //8bit
  ral_fld_set   ("CONFIG_AAA.param_1", 254); //8bit
  ral_fld_set   ("CONFIG_AAA.param_2",  1); //4bit
  ral_fld_set   ("CONFIG_AAA.param_3", 15); //4bit
  ral_fld_set   ("CONFIG_AAA.param_4",  3); //2bit
  ral_fld_set   ("CONFIG_AAA.param_5",  3); //2bit
  ral_fld_set   ("CONFIG_AAA.param_6",  2); //2bit
  ral_fld_set   ("CONFIG_AAA.param_7",  2); //2bit
  sv_print("CONFIG_AAA Before Update");
  ral_reg_print ("CONFIG_AAA");
  ral_fld_print ("CONFIG_AAA.param_0");
  ral_fld_print ("CONFIG_AAA.param_1");
  ral_fld_print ("CONFIG_AAA.param_2");
  ral_fld_print ("CONFIG_AAA.param_3");
  ral_fld_print ("CONFIG_AAA.param_4");
  ral_fld_print ("CONFIG_AAA.param_5");
  ral_fld_print ("CONFIG_AAA.param_6");
  ral_fld_print ("CONFIG_AAA.param_7");
  sv_print("CONFIG_AAA Is To Be Updated.");
  ral_reg_update("CONFIG_AAA");
  sv_print("CONFIG_AAA Was Updated.");
  //-----------------------------------------------------
  sv_print("CONFIG_AAA After Update");
  ral_reg_print ("CONFIG_AAA");
  ral_fld_print ("CONFIG_AAA.param_0");
  ral_fld_print ("CONFIG_AAA.param_1");
  ral_fld_print ("CONFIG_AAA.param_2");
  ral_fld_print ("CONFIG_AAA.param_3");
  ral_fld_print ("CONFIG_AAA.param_4");
  ral_fld_print ("CONFIG_AAA.param_5");
  ral_fld_print ("CONFIG_AAA.param_6");
  ral_fld_print ("CONFIG_AAA.param_7");

  //---------------- CONFIG_AAA Field Read --------------
  sv_print("");
  sv_print("-------------------------------------");
  sv_print("  CONFIG_AAA Read Access");
  sv_print("-------------------------------------");
  ral_reg_mirror("CONFIG_AAA");    
  ral_reg_print ("CONFIG_AAA");
  ral_fld_print ("CONFIG_AAA.param_0");
  ral_fld_print ("CONFIG_AAA.param_1");
  ral_fld_print ("CONFIG_AAA.param_2");
  ral_fld_print ("CONFIG_AAA.param_3");
  ral_fld_print ("CONFIG_AAA.param_4");
  ral_fld_print ("CONFIG_AAA.param_5");
  ral_fld_print ("CONFIG_AAA.param_6");
  ral_fld_print ("CONFIG_AAA.param_7");
  //-----------------------------------------------------
}

void CONFIG_HHH_field_access(void)
{
  //---------------- CONFIG_HHH Field Read ------------
  sv_print("");
  sv_print("-------------------------------------");
  sv_print("  CONFIG_HHH Read Access");
  sv_print("-------------------------------------");
//reg_read_print("CONFIG_HHH");
  ral_reg_mirror("CONFIG_HHH");    
  ral_reg_print ("CONFIG_HHH");
  ral_fld_print ("CONFIG_HHH.param_0");
  ral_fld_print ("CONFIG_HHH.param_1");
  ral_fld_print ("CONFIG_HHH.param_2");
  ral_fld_print ("CONFIG_HHH.param_3");
  //-----------------------------------------------------

  //---------------- CONFIG_HHH Field Write ------------
  sv_print("");
  sv_print("-------------------------------------");
  sv_print("  CONFIG_HHH Write Access");
  sv_print("-------------------------------------");
  ral_fld_set   ("CONFIG_HHH.param_0" ,10); //4bit
  ral_fld_set   ("CONFIG_HHH.param_1", 11); //4bit
  ral_fld_set   ("CONFIG_HHH.param_2", 12); //4bit
  ral_fld_set   ("CONFIG_HHH.param_3", 13); //4bit
  ral_reg_update("CONFIG_HHH");
  sv_print("CONFIG_HHH Was Updated.");
  //-----------------------------------------------------

  //---------------- CONFIG_HHH Field Read --------------
  sv_print("");
  sv_print("-------------------------------------");
  sv_print("  CONFIG_HHH Read Access");
  sv_print("-------------------------------------");
  ral_reg_mirror("CONFIG_HHH");    
  ral_reg_print ("CONFIG_HHH");
  ral_fld_print ("CONFIG_HHH.param_0");
  ral_fld_print ("CONFIG_HHH.param_1");
  ral_fld_print ("CONFIG_HHH.param_2");
  ral_fld_print ("CONFIG_HHH.param_3");
  //-----------------------------------------------------
}

//extern "C" void C_reg_sequence(int id) //const char * p_name, int id)
//extern "C" void C_reg_sequence(const char * p_name, int id)
int C_reg_sequence(const char * p_name, int id)
{
//int * RDATA;
  cout << "##################################################################" << endl;
  cout << "  C++ function C_reg_sequence() was called from [" << p_name << ", " << id << "]" << endl;
  cout << "##################################################################" << endl;
  cout << "----------------------------------------------------" << endl;

  if (strcmp(p_name,"c_ral_seq") == 0)
  {
  //ral_reg_write ("CONFIG_AAA", 5); reg_read_print("CONFIG_AAA");
    ral_reg_write ("CONFIG_BBB",15); reg_read_print("CONFIG_BBB");
    ral_reg_write ("CONFIG_CCC", 3); reg_read_print("CONFIG_CCC");
    ral_reg_write ("CONFIG_DDD",11); reg_read_print("CONFIG_DDD");
    ral_reg_write ("CONFIG_EEE",33); reg_read_print("CONFIG_EEE");
    ral_reg_write ("CONFIG_FFF", 5); reg_read_print("CONFIG_FFF");
    ral_reg_write ("CONFIG_GGG",15); reg_read_print("CONFIG_GGG");
    ral_reg_write ("CONFIG_HHH", 3); reg_read_print("CONFIG_HHH");

    if (id == 0) CONFIG_AAA_field_access();

    // Illegal Access
    ral_reg_write ("CONFIG_XXX", 5); reg_read_print("CONFIG_XXX");    
    ral_fld_print ("CONFIG_HHH.param_999");
  }

  if (strcmp(p_name,"unite_seq") == 0) CONFIG_HHH_field_access();


  cout << "----------------------------------------------------" << endl;
  return 1;
}

