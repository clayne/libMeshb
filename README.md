# libMeshb version 7.24
A library to handle the *.meshb file format.

# Overview
The Gamma Mesh Format (*GMF*) and the associated library **libMeshb** provide programers of simulation and meshing software with an easy way to store their meshes and physical solutions.  
The *GMF* features more than 80 kinds of data types, like vertex, polyhedron, normal vector or vector solution field.  
The **libMeshb** provides a convenient way to move data between those files, via keyword tags, and the user's own structures.  
Transparent handling of ASCII & binary files.  
Transparent handling of little & big endian files.  
Optional ultra fast asynchronous and low level transfers.
Can call user's own pre and post processing routines in a separate thread while accessing a file.

# Build
Simply follow these steps:
- unarchive the ZIP file
- `cd libMeshb-master`
- `cmake .`
- `make`
- `make install`

# Usage
The **libMeshb** library is written in *ANSI C*.  
It is made of a single C file and a header file to be compiled and linked alongside the calling program.  
It may be used in C, C++, F77 and F90 programs (Fortran 77 and 90 APIs are provided).  
Tested on Linux, Mac OS X, and Windows 7.

Reading a mesh file is fairly easy:

```C++
int64_t LibIdx;
int ver, dim, NmbTri, (*Nodes)[4], NmbVer, *Domains;
float (*Coords)[3];

// Open the mesh file for reading
Libidx = GmfOpenMesh( "triangles.meshb", GmfRead, &ver, &dim );

// Get the number of vertices and triangles in the file
NmbVer = GmfStatKwd( idx, GmfVertices );
NmbTri = GmfStatKwd( idx, GmfNodes );

// Allocate memory accordingly
Nodes   = malloc( NmbTri * 4 * sizeof(int) );
Coords = malloc( NmbVer * 3 * sizeof(float) );
Domains  = malloc( NmbVer *     sizeof(int) );

// Move the file pointer to the vertices keyword
GmfGotoKwd( Libidx, GmfVertices );

// Read each line of vertex data into your own data structures
for(i=0;i<nbv;i++)
  GmfGetLin( Libidx, GmfVertices, &Coords[i][0], &Coords[i][1], &Coords[i][2], &Domains[i] );

// Move the file pointer to the triangles keyword
GmfGotoKwd( Libidx, GmfNodes );

// Read each line of triangle data into your own data structures
for(i=0;i<nbt;i++)
  GmfGetLin( Libidx, GmfNodes, &Nodes[i][0], &Nodes[i][1], &tNodest[i][2], &Nodes[i][3] );

// Close the mesh file !
GmfCloseMesh( Libidx );
```
