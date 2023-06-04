#include <stdio.h>
#include <iostream>
#include <string>

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
  string msg;
  ral_reg_read(regname.c_str(), &val);
  msg = "#### REGISTER READ VALUE : " + regname + " = " + to_string(val);
  sv_print(msg.c_str());
}

void ral_fld_print(string fldname)
{
  string msg;
  msg = fldname + " : " + to_string(ral_fld_get(fldname.c_str()));
  sv_print(msg.c_str());
}

//extern "C" void C_reg_sequence(int id) //const char * p_name, int id)
//extern "C" void C_reg_sequence(const char * p_name, int id)
int C_reg_sequence(const char * p_name, int id)
{
//int * RDATA;
  cout << "####################################################" << endl;
  cout << "  C++ function C_Program() was called from " << p_name << ", " << id << endl;
  cout << "####################################################" << endl;
  cout << "----------------------------------------------------" << endl;
  ral_reg_write ("CONFIG_AAA", 5);
  ral_reg_write ("CONFIG_BBB",15);
  ral_reg_write ("CONFIG_CCC", 3);
  ral_reg_write ("CONFIG_DDD",11);
  ral_reg_write ("CONFIG_EEE",33);
  ral_reg_write ("CONFIG_FFF", 5);
  ral_reg_write ("CONFIG_GGG",15);
  ral_reg_write ("CONFIG_HHH", 3);
  reg_read_print("CONFIG_AAA");
  reg_read_print("CONFIG_BBB");
  reg_read_print("CONFIG_CCC");
  reg_read_print("CONFIG_DDD");
  reg_read_print("CONFIG_EEE");
  reg_read_print("CONFIG_FFF");
  reg_read_print("CONFIG_GGG");
  reg_read_print("CONFIG_HHH");
  //---------------- Write CONFIG_AAA------------
  ral_fld_set   ("CONFIG_AAA.param_0" ,1);
  ral_fld_set   ("CONFIG_AAA.param_1", 3);
  ral_fld_set   ("CONFIG_AAA.param_2", 3);
  ral_fld_set   ("CONFIG_AAA.param_6", 2);
  ral_reg_update("CONFIG_AAA");
  //---------------------------------------------
  //---------------- Read  CONFIG_AAA------------
  reg_read_print("CONFIG_AAA");    
  ral_fld_print ("CONFIG_AAA.param_0");
  ral_fld_print ("CONFIG_AAA.param_1");
  ral_fld_print ("CONFIG_AAA.param_2");
  ral_fld_print ("CONFIG_AAA.param_3");
  ral_fld_print ("CONFIG_AAA.param_4");
  ral_fld_print ("CONFIG_AAA.param_5");
  ral_fld_print ("CONFIG_AAA.param_6");
  //---------------------------------------------
  //---------------- Write CONFIG_XXX------------
  ral_reg_write ("CONFIG_XXX", 5);
  //---------------------------------------------
  //---------------- Read  CONFIG_XXX------------
  reg_read_print("CONFIG_XXX");    
  //---------------------------------------------
//cout << "  RDATA : " << RDATA << endl;
  cout << "----------------------------------------------------" << endl;
  return 1;
}

