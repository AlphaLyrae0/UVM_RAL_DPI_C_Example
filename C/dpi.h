
extern "C" void sv_print      (const char *);

extern "C" void ral_reg_write (const char *, int );
extern "C" void ral_reg_set   (const char *, int );
extern "C" void ral_regfld_set(const char *, int );
extern "C" void ral_fld_set   (const char *, const char *, int );
extern "C" void ral_reg_update(const char *);

extern "C" void ral_reg_read  (const char *, int *);
extern "C" void ral_reg_mirror(const char *);
extern "C" int  ral_reg_get   (const char *);
extern "C" int  ral_fld_get   (const char *, const char *);

//extern "C" void C_reg_sequence(int id); //const char * p_name, int id)
//extern "C" void C_reg_sequence(const char * p_name, int id);
  extern "C" int  C_reg_sequence(const char * p_name, int id);