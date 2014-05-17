/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright by The HDF Group.                                               *
 * Copyright by the Board of Trustees of the University of Illinois.         *
 * All rights reserved.                                                      *
 *                                                                           *
 * This file is part of HDF5.  The full HDF5 copyright notice, including     *
 * terms governing use, modification, and redistribution, is contained in    *
 * the files COPYING and Copyright.html.  COPYING can be found at the root   *
 * of the source code distribution tree; Copyright.html can be found at the  *
 * root level of an installed copy of the electronic HDF5 document set and   *
 * is linked from the top-level documents page.  It can also be found at     *
 * http://hdfgroup.org/HDF5/doc/Copyright.html.  If you do not have          *
 * access to either file, you may request a copy from help@hdfgroup.org.     *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

module hdf5.H5Ipublic;

/*
 * This file contains function prototypes for each exported function in
 * the H5I module.
 */

/* Public headers needed by this file */
import hdf5.H5public;

extern(C):

/*
 * Library type values.  Start with `1' instead of `0' because it makes the
 * tracing output look better when hid_t values are large numbers.  Change the
 * TYPE_BITS in H5I.c if the MAXID gets larger than 32 (an assertion will
 * fail otherwise).
 *
 * When adding types here, add a section to the 'misc19' test in test/tmisc.c
 * to verify that the H5I{inc|dec|get}_ref() routines work correctly with in.
 *
 */

enum H5I_type_t {
    H5I_UNINIT		= (-2), /*uninitialized type			    */
    H5I_BADID		= (-1),	/*invalid Type				    */
    H5I_FILE		= 1,	/*type ID for File objects		    */
    H5I_GROUP,		        /*type ID for Group objects		    */
    H5I_DATATYPE,	        /*type ID for Datatype objects		    */
    H5I_DATASPACE,	        /*type ID for Dataspace objects		    */
    H5I_DATASET,	        /*type ID for Dataset objects		    */
    H5I_ATTR,		        /*type ID for Attribute objects		    */
    H5I_REFERENCE,	        /*type ID for Reference objects		    */
    H5I_VFL,			/*type ID for virtual file layer	    */
    H5I_GENPROP_CLS,            /*type ID for generic property list classes */
    H5I_GENPROP_LST,            /*type ID for generic property lists        */
    H5I_ERROR_CLASS,            /*type ID for error classes		    */
    H5I_ERROR_MSG,              /*type ID for error messages		    */
    H5I_ERROR_STACK,            /*type ID for error stacks		    */
    H5I_NTYPES		        /*number of library types, MUST BE LAST!    */
}

/* Type of atoms to return to users */
alias int hid_t;
enum H5_SIZEOF_HID_T = H5_SIZEOF_INT;

/* An invalid object ID. This is also negative for error return. */
enum H5I_INVALID_HID = (-1);

/*
 * Function for freeing objects. This function will be called with an object
 * ID type number and a pointer to the object. The function should free the
 * object and return non-negative to indicate that the object
 * can be removed from the ID type. If the function returns negative
 * (failure) then the object will remain in the ID type.
 */
alias herr_t (*H5I_free_t)(void*);

/* Type of the function to compare objects & keys */
alias int (*H5I_search_func_t)(void *obj, hid_t id, void *key);

/* Public API functions */

version(Posix) {
  hid_t H5Iregister(H5I_type_t type, const void *object);
  void *H5Iobject_verify(hid_t id, H5I_type_t id_type);
  void *H5Iremove_verify(hid_t id, H5I_type_t id_type);
  H5I_type_t H5Iget_type(hid_t id);
  hid_t H5Iget_file_id(hid_t id);
  ssize_t H5Iget_name(hid_t id, char *name/*out*/, size_t size);
  int H5Iinc_ref(hid_t id);
  int H5Idec_ref(hid_t id);
  int H5Iget_ref(hid_t id);
  H5I_type_t H5Iregister_type(size_t hash_size, uint reserved, H5I_free_t free_func);
  herr_t H5Iclear_type(H5I_type_t type, hbool_t force);
  herr_t H5Idestroy_type(H5I_type_t type);
  int H5Iinc_type_ref(H5I_type_t type);
  int H5Idec_type_ref(H5I_type_t type);
  int H5Iget_type_ref(H5I_type_t type);
  void *H5Isearch(H5I_type_t type, H5I_search_func_t func, void *key);
  herr_t H5Inmembers(H5I_type_t type, hsize_t *num_members);
  htri_t H5Itype_exists(H5I_type_t type);
  htri_t H5Iis_valid(hid_t id);
}

