!----------------------------------------------------------
!
!                       LIBMESH V 7.79
! 
!----------------------------------------------------------
!
!   Description:         handles .meshb file format I/O
!   Author:              Loic MARECHAL
!                        Christophe PEYRET (ONERA/DAAA)
!   Creation date:       dec 08 2015
!   Last modification:   mar 13 2024
!
!----------------------------------------------------------

module libmeshb7
  
  use iso_fortran_env
  use, intrinsic :: iso_c_binding, only: c_int,c_long,c_loc,c_ptr,c_null_ptr
  
  implicit none
  
  ! Procedures definition
  integer(int64) , external :: GmfOpenMeshF77
  integer(int32) , external :: GmfCloseMeshF77
  integer(int32) , external :: GmfStatKwdF77
  integer(int32) , external :: GmfSetkwdF77
  integer(int32) , external :: GmfGotokwdF77
  integer(int32) , external :: GmfSetHONodesorderingF77
  integer(int32) , external :: GmfGetLineF77
  integer(int32) , external :: GmfSetLineF77
  integer(int32) , external :: GmfGetBlockF77
  integer(int32) , external :: GmfSetBlockF77
  integer(int32) , external :: GmfSetReferencestringF77
  
  ! Parameters definition
  integer(int32), parameter :: gmfmaxtyp=1000
  integer(int32), parameter :: gmfmaxkwd=227
  integer(int32), parameter :: gmfread=1
  integer(int32), parameter :: gmfwrite=2
  integer(int32), parameter :: gmfsca=1
  integer(int32), parameter :: gmfvec=2
  integer(int32), parameter :: gmfsymmat=3
  integer(int32), parameter :: gmfmat=4
  integer(int32), parameter :: gmffloat=8
  integer(int32), parameter :: gmfdouble=9
  integer(int32), parameter :: gmfint=10
  integer(int32), parameter :: gmflong=11
  integer(int32), parameter :: gmfinttab=14
  integer(int32), parameter :: gmflongtab=15
  integer(int32), parameter :: gmffloatvec=12
  integer(int32), parameter :: gmfdoublevec=13
  integer(int32), parameter :: gmfintvec=14
  integer(int32), parameter :: gmflongvec=15
  integer(int32), parameter :: gmfargtab=100
  integer(int32), parameter :: gmfarglst=101
  
  ! Keywords list
  integer(int32), parameter :: gmfdimension=3
  integer(int32), parameter :: gmfmeshversionformatted=1
  integer(int32), parameter :: gmfvertices=4
  integer(int32), parameter :: gmfedges=5
  integer(int32), parameter :: gmftriangles=6
  integer(int32), parameter :: gmfquadrilaterals=7
  integer(int32), parameter :: gmftetrahedra=8
  integer(int32), parameter :: gmfprisms=9
  integer(int32), parameter :: gmfhexahedra=10
  integer(int32), parameter :: gmfiterationsall=11
  integer(int32), parameter :: gmftimesall=12
  integer(int32), parameter :: gmfcorners=13
  integer(int32), parameter :: gmfridges=14
  integer(int32), parameter :: gmfrequiredvertices=15
  integer(int32), parameter :: gmfrequirededges=16
  integer(int32), parameter :: gmfrequiredtriangles=17
  integer(int32), parameter :: gmfrequiredquadrilaterals=18
  integer(int32), parameter :: gmftangentatedgevertices=19
  integer(int32), parameter :: gmfnormalatvertices=20
  integer(int32), parameter :: gmfnormalattrianglevertices=21
  integer(int32), parameter :: gmfnormalatquadrilateralvertices=22
  integer(int32), parameter :: gmfangleofcornerbound=23
  integer(int32), parameter :: gmftrianglesp2=24
  integer(int32), parameter :: gmfedgesp2=25
  integer(int32), parameter :: gmfsolatpyramids=26
  integer(int32), parameter :: gmfquadrilateralsq2=27
  integer(int32), parameter :: gmfisolatpyramids=28
  integer(int32), parameter :: gmfsubdomainfromgeom=29
  integer(int32), parameter :: gmftetrahedrap2=30
  integer(int32), parameter :: gmffault_neartri=31
  integer(int32), parameter :: gmffault_inter=32
  integer(int32), parameter :: gmfhexahedraq2=33
  integer(int32), parameter :: gmfextraverticesatedges=34
  integer(int32), parameter :: gmfextraverticesattriangles=35
  integer(int32), parameter :: gmfextraverticesatquadrilaterals=36
  integer(int32), parameter :: gmfextraverticesattetrahedra=37
  integer(int32), parameter :: gmfextraverticesatprisms=38
  integer(int32), parameter :: gmfextraverticesathexahedra=39
  integer(int32), parameter :: gmfverticesongeometricvertices=40
  integer(int32), parameter :: gmfverticesongeometricedges=41
  integer(int32), parameter :: gmfverticesongeometrictriangles=42
  integer(int32), parameter :: gmfverticesongeometricquadrilaterals=43
  integer(int32), parameter :: gmfedgesongeometricedges=44
  integer(int32), parameter :: gmffault_freeedge=45
  integer(int32), parameter :: gmfpolyhedra=46
  integer(int32), parameter :: gmfpolygons=47
  integer(int32), parameter :: gmffault_overlap=48
  integer(int32), parameter :: gmfpyramids=49
  integer(int32), parameter :: gmfboundingbox=50
  integer(int32), parameter :: gmfbody=51
  integer(int32), parameter :: gmfprivatetable=52
  integer(int32), parameter :: gmffault_badshape=53
  integer(int32), parameter :: gmfend=54
  integer(int32), parameter :: gmftrianglesongeometrictriangles=55
  integer(int32), parameter :: gmftrianglesongeometricquadrilaterals=56
  integer(int32), parameter :: gmfquadrilateralsongeometrictriangles=57
  integer(int32), parameter :: gmfquadrilateralsongeometricquadrilaterals=58
  integer(int32), parameter :: gmftangents=59
  integer(int32), parameter :: gmfnormals=60
  integer(int32), parameter :: gmftangentatvertices=61
  integer(int32), parameter :: gmfsolatvertices=62
  integer(int32), parameter :: gmfsolatedges=63
  integer(int32), parameter :: gmfsolattriangles=64
  integer(int32), parameter :: gmfsolatquadrilaterals=65
  integer(int32), parameter :: gmfsolattetrahedra=66
  integer(int32), parameter :: gmfsolatprisms=67
  integer(int32), parameter :: gmfsolathexahedra=68
  integer(int32), parameter :: gmfdsolatvertices=69
  integer(int32), parameter :: gmfisolatvertices=70
  integer(int32), parameter :: gmfisolatedges=71
  integer(int32), parameter :: gmfisolattriangles=72
  integer(int32), parameter :: gmfisolatquadrilaterals=73
  integer(int32), parameter :: gmfisolattetrahedra=74
  integer(int32), parameter :: gmfisolatprisms=75
  integer(int32), parameter :: gmfisolathexahedra=76
  integer(int32), parameter :: gmfiterations=77
  integer(int32), parameter :: gmftime=78
  integer(int32), parameter :: gmffault_smalltri=79
  integer(int32), parameter :: gmfcoarsehexahedra=80
  integer(int32), parameter :: gmfcomments=81
  integer(int32), parameter :: gmfperiodicvertices=82
  integer(int32), parameter :: gmfperiodicedges=83
  integer(int32), parameter :: gmfperiodictriangles=84
  integer(int32), parameter :: gmfperiodicquadrilaterals=85
  integer(int32), parameter :: gmfprismsp2=86
  integer(int32), parameter :: gmfpyramidsp2=87
  integer(int32), parameter :: gmfquadrilateralsq3=88
  integer(int32), parameter :: gmfquadrilateralsq4=89
  integer(int32), parameter :: gmftrianglesp3=90
  integer(int32), parameter :: gmftrianglesp4=91
  integer(int32), parameter :: gmfedgesp3=92
  integer(int32), parameter :: gmfedgesp4=93
  integer(int32), parameter :: gmfirefgroups=94
  integer(int32), parameter :: gmfdrefgroups=95
  integer(int32), parameter :: gmftetrahedrap3=96
  integer(int32), parameter :: gmftetrahedrap4=97
  integer(int32), parameter :: gmfhexahedraq3=98
  integer(int32), parameter :: gmfhexahedraq4=99
  integer(int32), parameter :: gmfpyramidsp3=100
  integer(int32), parameter :: gmfpyramidsp4=101
  integer(int32), parameter :: gmfprismsp3=102
  integer(int32), parameter :: gmfprismsp4=103
  integer(int32), parameter :: gmfhosolatedgesp1=104
  integer(int32), parameter :: gmfhosolatedgesp2=105
  integer(int32), parameter :: gmfhosolatedgesp3=106
  integer(int32), parameter :: gmfhosolattrianglesp1=107
  integer(int32), parameter :: gmfhosolattrianglesp2=108
  integer(int32), parameter :: gmfhosolattrianglesp3=109
  integer(int32), parameter :: gmfhosolatquadrilateralsq1=110
  integer(int32), parameter :: gmfhosolatquadrilateralsq2=111
  integer(int32), parameter :: gmfhosolatquadrilateralsq3=112
  integer(int32), parameter :: gmfhosolattetrahedrap1=113
  integer(int32), parameter :: gmfhosolattetrahedrap2=114
  integer(int32), parameter :: gmfhosolattetrahedrap3=115
  integer(int32), parameter :: gmfhosolatpyramidsp1=116
  integer(int32), parameter :: gmfhosolatpyramidsp2=117
  integer(int32), parameter :: gmfhosolatpyramidsp3=118
  integer(int32), parameter :: gmfhosolatprismsp1=119
  integer(int32), parameter :: gmfhosolatprismsp2=120
  integer(int32), parameter :: gmfhosolatprismsp3=121
  integer(int32), parameter :: gmfhosolathexahedraq1=122
  integer(int32), parameter :: gmfhosolathexahedraq2=123
  integer(int32), parameter :: gmfhosolathexahedraq3=124
  integer(int32), parameter :: gmfbezierbasis=125
  integer(int32), parameter :: gmfbyteflow=126
  integer(int32), parameter :: gmfedgesp2ordering=127
  integer(int32), parameter :: gmfedgesp3ordering=128
  integer(int32), parameter :: gmftrianglesp2ordering=129
  integer(int32), parameter :: gmftrianglesp3ordering=130
  integer(int32), parameter :: gmfquadrilateralsq2ordering=131
  integer(int32), parameter :: gmfquadrilateralsq3ordering=132
  integer(int32), parameter :: gmftetrahedrap2ordering=133
  integer(int32), parameter :: gmftetrahedrap3ordering=134
  integer(int32), parameter :: gmfpyramidsp2ordering=135
  integer(int32), parameter :: gmfpyramidsp3ordering=136
  integer(int32), parameter :: gmfprismsp2ordering=137
  integer(int32), parameter :: gmfprismsp3ordering=138
  integer(int32), parameter :: gmfhexahedraq2ordering=139
  integer(int32), parameter :: gmfhexahedraq3ordering=140
  integer(int32), parameter :: gmfedgesp1ordering=141
  integer(int32), parameter :: gmfedgesp4ordering=142
  integer(int32), parameter :: gmftrianglesp1ordering=143
  integer(int32), parameter :: gmftrianglesp4ordering=144
  integer(int32), parameter :: gmfquadrilateralsq1ordering=145
  integer(int32), parameter :: gmfquadrilateralsq4ordering=146
  integer(int32), parameter :: gmftetrahedrap1ordering=147
  integer(int32), parameter :: gmftetrahedrap4ordering=148
  integer(int32), parameter :: gmfpyramidsp1ordering=149
  integer(int32), parameter :: gmfpyramidsp4ordering=150
  integer(int32), parameter :: gmfprismsp1ordering=151
  integer(int32), parameter :: gmfprismsp4ordering=152
  integer(int32), parameter :: gmfhexahedraq1ordering=153
  integer(int32), parameter :: gmfhexahedraq4ordering=154
  integer(int32), parameter :: gmffloatingpointprecision=155
  integer(int32), parameter :: gmfhosolatedgesp4=156
  integer(int32), parameter :: gmfhosolattrianglesp4=157
  integer(int32), parameter :: gmfhosolatquadrilateralsq4=158
  integer(int32), parameter :: gmfhosolattetrahedrap4=159
  integer(int32), parameter :: gmfhosolatpyramidsp4=160
  integer(int32), parameter :: gmfhosolatprismsp4=161
  integer(int32), parameter :: gmfhosolathexahedraq4=162
  integer(int32), parameter :: gmfhosolatedgesp1nodespositions=163
  integer(int32), parameter :: gmfhosolatedgesp2nodespositions=164
  integer(int32), parameter :: gmfhosolatedgesp3nodespositions=165
  integer(int32), parameter :: gmfhosolatedgesp4nodespositions=166
  integer(int32), parameter :: gmfhosolattrianglesp1nodespositions=167
  integer(int32), parameter :: gmfhosolattrianglesp2nodespositions=168
  integer(int32), parameter :: gmfhosolattrianglesp3nodespositions=169
  integer(int32), parameter :: gmfhosolattrianglesp4nodespositions=170
  integer(int32), parameter :: gmfhosolatquadrilateralsq1nodespositions=171
  integer(int32), parameter :: gmfhosolatquadrilateralsq2nodespositions=172
  integer(int32), parameter :: gmfhosolatquadrilateralsq3nodespositions=173
  integer(int32), parameter :: gmfhosolatquadrilateralsq4nodespositions=174
  integer(int32), parameter :: gmfhosolattetrahedrap1nodespositions=175
  integer(int32), parameter :: gmfhosolattetrahedrap2nodespositions=176
  integer(int32), parameter :: gmfhosolattetrahedrap3nodespositions=177
  integer(int32), parameter :: gmfhosolattetrahedrap4nodespositions=178
  integer(int32), parameter :: gmfhosolatpyramidsp1nodespositions=179
  integer(int32), parameter :: gmfhosolatpyramidsp2nodespositions=180
  integer(int32), parameter :: gmfhosolatpyramidsp3nodespositions=181
  integer(int32), parameter :: gmfhosolatpyramidsp4nodespositions=182
  integer(int32), parameter :: gmfhosolatprismsp1nodespositions=183
  integer(int32), parameter :: gmfhosolatprismsp2nodespositions=184
  integer(int32), parameter :: gmfhosolatprismsp3nodespositions=185
  integer(int32), parameter :: gmfhosolatprismsp4nodespositions=186
  integer(int32), parameter :: gmfhosolathexahedraq1nodespositions=187
  integer(int32), parameter :: gmfhosolathexahedraq2nodespositions=188
  integer(int32), parameter :: gmfhosolathexahedraq3nodespositions=189
  integer(int32), parameter :: gmfhosolathexahedraq4nodespositions=190
  integer(int32), parameter :: gmfedgesreferenceelement=191
  integer(int32), parameter :: gmftrianglereferenceelement=192
  integer(int32), parameter :: gmfquadrilateralreferenceelement=193
  integer(int32), parameter :: gmftetrahedronreferenceelement=194
  integer(int32), parameter :: gmfpyramidreferenceelement=195
  integer(int32), parameter :: gmfprismreferenceelement=196
  integer(int32), parameter :: gmfhexahedronreferenceelement=197
  integer(int32), parameter :: gmfboundarylayers=198
  integer(int32), parameter :: gmfreferencestrings=199
  integer(int32), parameter :: gmfprisms9=200
  integer(int32), parameter :: gmfhexahedra12=201
  integer(int32), parameter :: gmfquadrilaterals6=202
  integer(int32), parameter :: gmfboundarypolygonheaders=203
  integer(int32), parameter :: gmfboundarypolygonvertices=204
  integer(int32), parameter :: gmfinnerpolygonheaders=205
  integer(int32), parameter :: gmfinnerpolygonvertices=206
  integer(int32), parameter :: gmfpolyhedraheaders=207
  integer(int32), parameter :: gmfpolyhedrafaces=208
  integer(int32), parameter :: gmfdomains=209
  integer(int32), parameter :: gmfverticesgid=210
  integer(int32), parameter :: gmfedgesgid=211
  integer(int32), parameter :: gmftrianglesgid=212
  integer(int32), parameter :: gmfquadrilateralsgid=213
  integer(int32), parameter :: gmftetrahedragid=214
  integer(int32), parameter :: gmfpyramidsgid=215
  integer(int32), parameter :: gmfprismsgid=216
  integer(int32), parameter :: gmfhexahedragid=217
  integer(int32), parameter :: gmfsolatboundarypolygons=218
  integer(int32), parameter :: gmfsolatpolyhedra=219
  integer(int32), parameter :: gmfverticesongeometrynodes=220
  integer(int32), parameter :: gmfverticesongeometryedges=221
  integer(int32), parameter :: gmfedgesongeometryedges=222
  integer(int32), parameter :: gmfverticesongeometryfaces=223
  integer(int32), parameter :: gmfedgesongeometryfaces=224
  integer(int32), parameter :: gmftrianglesongeometryfaces=225
  integer(int32), parameter :: gmfquadrialteralsongeometryfaces=226
  integer(int32), parameter :: gmfmeshongeometry=227
  
  interface     GmfStatKwdF90
    module procedure GmfStatKwdF90_0       !> vertices & nodes
    module procedure GmfStatKwdF90_1       !> solutions       
  end interface GmfStatKwdF90
  
  interface     GmfSetKwdF90
    module procedure GmfSetKwdF90_0        !> vertices & nodes
    module procedure GmfSetKwdF90_1        !> solutions       
  end interface GmfSetKwdF90
  
  interface     GmfGetLineF90
    module procedure GmfGetLineF90_i       !> int32 (:) + int32
    module procedure GmfGetLineF90_i_      !> int32 (:)        
    module procedure GmfGetLineF90_i__     !> int32            
    module procedure GmfGetLineF90_d       !> real64(:) + int32
    module procedure GmfGetLineF90_d_      !> real64(:)        
    module procedure GmfGetLineF90_d__     !> real64           
  end interface GmfGetLineF90
  
  interface     GmfSetLineF90
    module procedure GmfSetLineF90_i       !> int32 (:) + int32
    module procedure GmfSetLineF90_i_      !> int32 (:)        
    module procedure GmfSetLineF90_i__     !> int32            
    module procedure GmfSetLineF90_d       !> real64(:) + int32
    module procedure GmfSetLineF90_d_      !> real64(:)        
    module procedure GmfSetLineF90_d__     !> real64           
  end interface GmfSetLineF90
  
  interface     GmfGetBlockF90
   !module procedure GmfGetBlockF90_00
    module procedure GmfGetBlockF90_i      !> int32 (:,:) + int32(;)
    module procedure GmfGetBlockF90_i_     !> int32 (:)   + int32(:)
    module procedure GmfGetBlockF90_i__    !> int32 (:,:)           
    module procedure GmfGetBlockF90_i___   !> int32 (:)             
    module procedure GmfGetBlockF90_d      !> real64(:,:) + int32(:)
    module procedure GmfGetBlockF90_d_     !> real64(:)   + int32(:)
    module procedure GmfGetBlockF90_d__    !> real64(:,:)           
    module procedure GmfGetBlockF90_d___   !> real64(:)             
  end interface GmfGetBlockF90
  
  interface     GmfSetBlockF90
   !module procedure GmfGetBlockF90_00
    module procedure GmfSetBlockF90_i      !> int32 (:,:) + int32(:)
    module procedure GmfSetBlockF90_i_     !> int32 (:)   + int32(:)
    module procedure GmfSetBlockF90_i__    !> int32 (:,:)          
    module procedure GmfSetBlockF90_i___   !> int32 (:)            
    module procedure GmfSetBlockF90_d      !> real64(:,:) + int32(:)
    module procedure GmfSetBlockF90_d_     !> real64(:)   + int32(:)
    module procedure GmfSetBlockF90_d__    !> real64(:,:)           
    module procedure GmfSetBlockF90_d___   !> real64(:)          
  end interface GmfSetBlockF90
  
contains
  
  function  GmfOpenMeshF90(name, GmfKey, ver, dim) result(unit)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    character(*)  , intent(in)    :: name
    integer(int32), intent(in)    :: GmfKey
    integer(int32)                :: ver
    integer(int32)                :: dim
    integer(int64)                :: unit
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    unit = GmfOpenMeshf77(trim(name), GmfKey, ver, dim)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfOpenMeshF90
  
  function     GmfCloseMeshF90(unit) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: res
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfCloseMeshF77(unit)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfCloseMeshF90
  
  function     GmfStatKwdF90_0(unit, GmfKey) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    integer(int32) :: Nmb
    integer(int32) :: res
    !>
    integer(int32) :: t(1),d,ho,s
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res = GmfStatKwdf77(unit, GmfKey, 0, 0, t(1), 0, 0)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfStatKwdF90_0
  
  function     GmfStatKwdF90_1(unit,GmfKey,NmbFields, strd ,fields ,ord, nNod ) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)           :: unit
    integer(int32), intent(in)           :: GmfKey
    integer(int32), intent(out)          :: NmbFields
    integer(int32), intent(out)          :: strd
    integer(int32), intent(out)          :: fields(:)
    integer(int32), intent(in), optional :: ord,nNod
    integer(int32)                       :: res
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    if( present(ord) .and. present(nNod) )then
      res=GmfStatKwdf77(unit, GmfKey, NmbFields, strd, fields(1), ord, nNod)
    else
      res=GmfStatKwdf77(unit, GmfKey, NmbFields, strd, fields(1), 0, 0)
    endif
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfStatKwdF90_1
  
  function     GmfGotoKwdF90(unit, GmfKey) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    integer(int32) :: res
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfgotokwdF77(unit, GmfKey)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGotoKwdF90
  
  function    GmfSetKwdF90_0(unit, GmfKey, Nmb) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    integer(int32) :: Nmb
    !>
    integer(int32) :: fields(1),d,ho,s
    integer(int32) :: res
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res = GmfSetKwdF77(unit, GmfKey, Nmb, 0, fields(1), 0, ho)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetKwdF90_0
  
  function     GmfSetKwdF90_1(unit, GmfKey, Nmb, NmbFields, fields, ord, nNod, fieldNames, iter, time) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    use iso_c_binding, only: C_NULL_CHAR
    integer(int64), intent(in)           :: unit
    integer(int32), intent(in)           :: GmfKey
    integer(int32), intent(in)           :: Nmb
    integer(int32), intent(in)           :: NmbFields
    integer(int32), intent(in)           :: fields(:)
    integer(int32), intent(in), optional :: ord 
    integer(int32), intent(in), optional :: nNod
    character(*)  , intent(in), optional :: fieldNames(:)
    integer(int32), intent(in), optional :: iter
    real(real64)  , intent(in), optional :: time
    integer(int32)                       :: res
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    if( present(iter) )then
      ! Write iteration number in file
      !print '(t3,"iter: ",i0)',iter
      res=GmfSetKwdF90 (unit=unit, GmfKey=GmfIterations, Nmb=1)
      res=GmfSetLineF90(unit=unit, GmfKey=GmfIterations, Tab=iter)
    endif
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    if( present(time) )then
      ! Write Time in solution file
      !print '(t3,"time: ",f12.5)',time
      res=GmfSetKwdF90 (unit=unit, GmfKey=GmfTime, Nmb=1   )
      res=GmfSetLineF90(unit=unit, GmfKey=GmfTime, Tab=time)
    endif
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    if( present(fieldNames) )then
      nomDesChamps : block
        integer(int32) :: iField
        
        res=GmfSetKwdF90 (unit=unit, GmfKey=GmfReferenceStrings, Nmb=NmbFields)
        do iField=1,NmbFields
          res=GmfSetReferencestringF77(unit, GmfKey, iField, trim(fieldNames(iField)))          
        enddo
      end block nomDesChamps
   endif
   !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
   !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
   if( present(ord) .and. present (nNod) )then
     res = GmfSetKwdF77(unit, GmfKey, Nmb, NmbFields, fields, ord, nNod)
   else
     res = GmfSetKwdF77(unit, GmfKey, Nmb, NmbFields, fields, 0, 0)
   endif
   !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 
   return
  end function GmfSetKwdF90_1
  
  function     GmfSetHONodesOrderingF90(unit, GmfKey, BasTab, OrdTab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    integer(int32) :: BasTab(:,:)
    integer(int32) :: OrdTab(:,:)
    integer(int32) :: res
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfSetHONodesOrderingF77(unit,GmfKey,BasTab,OrdTab)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetHONodesOrderingF90
  
  function     GmfGetLineF90_i(unit, GmfKey, Tab, Ref) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    !> Reading Nodes and Ref
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    integer(int32) :: Tab(:)
    integer(int32) :: Ref
    integer(int32) :: res
    !>
    real(real64)   :: dTab(1)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfGetLineF77(unit, GmfKey, Tab(1), dTab(1), Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetLineF90_i
  
  function     GmfGetLineF90_i_(unit, GmfKey, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    integer(int32) :: Tab(:)
    integer(int32) :: res
    !>
    real(real64)   :: dTab(1)
    integer(int32) :: Ref
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfGetLineF77(unit, GmfKey, Tab(1), dTab(1), Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetLineF90_i_
  
  function     GmfGetLineF90_i__(unit, GmfKey, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    integer(int32) :: Tab
    integer(int32) :: res
    !>
    real(real64)   :: dTab(1)
    integer(int32) :: Ref
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfGetLineF77(unit, GmfKey, Tab, dTab(1), Ref)
    !WARNING GmfGetLineF77 lit le double
    !Tab=dTab(1)
    !print '("GmfGetLineF90_i__ Tab=",*(i0,1x))',Tab
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetLineF90_i__
  
  function     GmfGetLineF90_d(unit, GmfKey, Tab, Ref) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    !> Reading Vertices and Ref
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    real(real64)   :: Tab(:)
    integer(int32) :: Ref
    integer(int32) :: res
    !>
    integer(int32) :: iTab(1)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfGetLineF77(unit, GmfKey, iTab(1), Tab(1), Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  end function GmfGetLineF90_d
  
  function     GmfGetLineF90_d_(unit, GmfKey, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    real(real64)   :: Tab(:)
    integer(int32) :: res
    !>
    integer(int32) :: iTab(1)
    integer(int32) :: Ref
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfGetLineF77(unit, GmfKey, iTab(1), Tab(1), Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  end function GmfGetLineF90_d_
  
  function     GmfGetLineF90_d__(unit, GmfKey, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    real(real64)   :: Tab
    integer(int32) :: res
    !>
    integer(int32) :: iTab(1)
    integer(int32) :: Ref
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfGetLineF77(unit, GmfKey, iTab(1), Tab, Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  end function GmfGetLineF90_d__
  
  function     GmfSetLineF90_i(unit, GmfKey, Tab, Ref) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    integer(int32) :: Tab(:)
    integer(int32) :: Ref
    integer(int32) :: res
    !>
    real(real64)   :: dTab(1)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfSetLineF77(unit, GmfKey, Tab(1), dTab(1), Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetLineF90_i
  
  function     GmfSetLineF90_d(unit, GmfKey, Tab, Ref) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    real(real64)   :: Tab(:)
    integer(int32) :: Ref
    integer(int32) :: res
    !>
    integer(int32) :: iTab(1)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfSetLineF77(unit, GmfKey, iTab(1), Tab(1), Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetLineF90_d
  
  function     GmfSetLineF90_i_(unit, GmfKey, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in) :: unit
    integer(int32), intent(in) :: GmfKey
    integer(int32), intent(in) :: Tab(:)
    integer(int32)             :: res
    !>    
    real(real64)               :: dTab(1)
    !real(real64), pointer      :: dTab(:)
    integer(int32)             :: Ref
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ! WARNING GmfSetLineF77 ecrit les double dans ce cas
    !print '("GmfSetLineF90_i_ Tab=",*(i0,1x))',Tab(:)
    
    !allocate(dTab(1:size(Tab)))    
    !dTab(:)=real(Tab(:),kind=real64) ! WARNING GmfSetLineF77 écrit double
    
    res=GmfSetLineF77(unit, GmfKey, Tab(1), dTab(1), Ref)
    !deallocate(dTab)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetLineF90_i_
  
  function     GmfSetLineF90_i__(unit, GmfKey, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in) :: unit
    integer(int32), intent(in) :: GmfKey
    integer(int32), intent(in) :: Tab
    integer(int32)             :: res
    !>
    real(real64)               :: dTab
    integer(int32)             :: Ref
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    ! WARNING GmfSetLineF77 ecrit les double dans ce cas
    !print '("GmfSetLineF90_i__ Tab=",i0)',Tab
    !dTab=real(Tab,kind=real64) 
    res=GmfSetLineF77(unit, GmfKey, Tab, dTab, Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetLineF90_i__
  
  function     GmfSetLineF90_d_(unit, GmfKey, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    real(real64)   :: Tab(:)
    integer(int32) :: res
    !>
    integer(int32) :: Ref
    integer(int32) :: iTab(1)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    res=GmfSetLineF77(unit, GmfKey, iTab(1), Tab(1), Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetLineF90_d_
  
  function     GmfSetLineF90_d__(unit, GmfKey, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64) :: unit
    integer(int32) :: GmfKey
    real(real64)   :: Tab
    integer(int32) :: res
    !>
    integer(int32) :: Ref
    integer(int32) :: iTab(1)
    real(real64)   :: dTab(1)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    dTab(1)=Tab
    res=GmfSetLineF77(unit, GmfKey, iTab(1), dTab(1), Ref)
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetLineF90_d__
  
  function     GmfGetBlockF90_00(unit, GmfKey, ad0, ad1, iTab, dTab, Ref) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(inout) :: iTab(:,:)
    real(real64)  , intent(inout) :: dTab(:,:)
    integer(int32), intent(inout) :: Ref(  :)
    integer(int32)                :: res
    !>
    integer(int32)                :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    res=GmfGetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  iTab(1,  1),&
    &                  iTab(1,Nmb),&
    &                  dTab(1,  1),&
    &                  dTab(1,Nmb),&
    &                   Ref(    1),&
    &                   Ref(  Nmb) )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetBlockF90_00
  
  function     GmfGetBlockF90_i(unit, GmfKey, ad0, ad1, Tab, Ref) result(res)
    !> int32 (:,:) + int32(;)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(inout) :: Tab(:,:)
    integer(int32), intent(inout) :: Ref(  :)
    integer(int32)                :: res
    !>
    integer(int32)                :: Nmb
    real(real64)                  :: dTab(1)
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfGetBlockF90_i (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfGetBlockF90_i size(Tab)=",i0,"x",i0)',size(Tab,1),size(Tab,2)
    !print '("GmfGetBlockF90_i size(Ref)=  ",i0)',size(Ref)
    
    res=GmfGetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  Tab(1,  1) ,&
    &                  Tab(1,Nmb) ,&
    &                  dTab(1)    ,&
    &                  dTab(1)    ,&
    &                  Ref(  1)   ,&
    &                  Ref(Nmb)    )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetBlockF90_i
  
  function     GmfGetBlockF90_i_(unit, GmfKey, ad0, ad1, strd, Tab, Ref) result(res)
    !> int32 (:)   + int32(:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: strd
    integer(int32), intent(inout) :: Tab(:)
    integer(int32), intent(inout) :: Ref(:)
    integer(int32)                :: res
    !>
    integer(int32)                :: Nmb
    real(real64)                  :: dTab(1)
    integer(int32), pointer       :: map(:)=>null()

    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfGetBlockF90_i_ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfGetBlockF90_i_ strd,size(Tab)/strd=",i0,"x",i0)',strd,size(Tab)/strd
    !print '("GmfGetBlockF90_i_ size(Ref)=  ",i0)',size(Ref)
    
    res=GmfGetBlockF77(unit                ,&
    &                  GmfKey              ,&
    &                  ad0                 ,&
    &                  ad1                 ,&
    &                  int32               ,&
    &                  map                 ,&
    &                  Tab(             1) ,&
    &                  Tab(strd*(Nmb-1)+1) ,&
    &                  dTab(1)             ,&
    &                  dTab(1)             ,&
    &                  Ref (  1)           ,&
    &                  Ref (Nmb)            )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetBlockF90_i_
  
  function     GmfGetBlockF90_i__(unit, GmfKey, ad0, ad1, Tab) result(res)
    !> int32 (:,:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(inout) :: Tab(:,:)
    integer(int32)                :: res
    !>
    real(real64)                  :: dTab(1,1)
    integer(int32)                :: Nmb
    integer(int32)                :: Ref(1)
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfGetBlockF90_i__ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfGetBlockF90_i__ size(Tab)=",i0,"x",i0)',size(Tab,1),size(Tab,2)
    
    res=GmfGetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  Tab(1,  1) ,&
    &                  Tab(1,Nmb) ,&
    &                  dTab(1,1)  ,&
    &                  dTab(1,1)  ,&
    &                  Ref(1)     ,&
    &                  Ref(1)      )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetBlockF90_i__

  function     GmfGetBlockF90_i___(unit, GmfKey, ad0, ad1, strd, Tab) result(res)
    !> int32 (:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: strd
    integer(int32), intent(inout) :: Tab(:)
    integer(int32)                :: res
    !>
    integer(int32)                :: Nmb
    real(real64)                  :: dTab(1)
    integer(int32)                :: Ref(1)
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfGetBlockF90_i___ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfGetBlockF90_i___ strd,size(Tab)/strd=",i0,"x",i0)',strd,size(Tab)/strd
      
    res=GmfGetBlockF77(unit                ,&
    &                  GmfKey              ,&
    &                  ad0                 ,&
    &                  ad1                 ,&
    &                  int32               ,&
    &                  map                 ,&
    &                  Tab(1)              ,&
    &                  Tab(strd*(Nmb-1)+1) ,&
    &                  dTab(1)             ,&
    &                  dTab(1)             ,&
    &                  Ref(1)              ,&
    &                  Ref(1)               )    
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    
    return
  end function GmfGetBlockF90_i___  
  
  function     GmfGetBlockF90_d(unit, GmfKey, ad0, ad1, Tab, Ref) result(res)
    !> real64(:,:) + int32(:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    real(real64)  , intent(inout) :: Tab(:,:)
    integer(int32), intent(inout) :: Ref(  :)
    integer(int32)                :: res
    !>
    integer(int32)                :: iTab(1)
    integer(int32)                :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfGetBlockF90_d (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfGetBlockF90_d size(Tab)=",i0,"x",i0)',size(Tab,1),size(Tab,2)
    !print '("GmfGetBlockF90_d size(Ref)=  ",i0)',size(Ref)
    
    res=GmfGetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  iTab(1)    ,&
    &                  iTab(1)    ,&
    &                  Tab(1,  1) ,&
    &                  Tab(1,Nmb) ,&
    &                  Ref(  1)   ,&
    &                  Ref(Nmb)    )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetBlockF90_d
  
  function     GmfGetBlockF90_d_(unit, GmfKey, ad0, ad1, strd, Tab, Ref) result(res)
    !> real64(:)   + int32(:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: strd
    real(real64)  , intent(inout) :: Tab(:)
    integer(int32), intent(inout) :: Ref(:)
    integer(int32)                :: res
    !>
    integer(int32) :: iTab(1)
    integer(int32) :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfGetBlockF90_d_ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfGetBlockF90_d_ strd,size(Tab)/strd=",i0,"x",i0)',strd,size(Tab)/strd
    !print '("GmfGetBlockF90_d_ size(Ref)=  ",i0)',size(Ref)
    
    res=GmfGetBlockF77(unit                ,&
    &                  GmfKey              ,&
    &                  ad0                 ,&
    &                  ad1                 ,&
    &                  int32               ,&
    &                  map                 ,&
    &                  iTab(1)             ,&
    &                  iTab(1)             ,&
    &                  Tab(1             ) ,&
    &                  Tab(strd*(Nmb-1)+1) ,&
    &                  Ref(  1)            ,&
    &                  Ref(Nmb)             )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetBlockF90_d_

  function     GmfGetBlockF90_d__(unit, GmfKey, ad0, ad1, Tab) result(res)
    !> real64(:,:)   
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    real(real64)  , intent(inout) :: Tab(:,:)
    integer(int32)                :: res
    !>
    integer(int32) :: Ref (1)
    integer(int32) :: iTab(1)
    integer(int32) :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfGetBlockF90_d__ size(Tab)=",i0,"x",i0)',size(Tab,1),size(Tab,2)
    !print '("GmfGetBlockF90_d__ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    
    res=GmfGetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  iTab(1)    ,&
    &                  iTab(1)    ,&
    &                  Tab(1,  1) ,&
    &                  Tab(1,Nmb) ,&
    &                  Ref(1)     ,&
    &                  Ref(1)      )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetBlockF90_d__
  
  function     GmfGetBlockF90_d___(unit, GmfKey, ad0, ad1, strd, Tab) result(res)
    !> real64(:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: strd
    real(real64)  , intent(inout) :: Tab(:)
    integer(int32)                :: res
    !>
    integer(int32) :: Ref (1)
    integer(int32) :: iTab(1)
    integer(int32) :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfGetBlockF90_d___ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfGetBlockF90_d___ strd,size(Tab)/strd=",i0,"x",i0)',strd,size(Tab)/strd
    !print '("GmfGetBlockF90_d___ size(Ref)=  ",i0)',size(Ref)
    
    res=GmfGetBlockF77(unit                ,&
    &                  GmfKey              ,&
    &                  ad0                 ,&
    &                  ad1                 ,&
    &                  int32               ,&
    &                  map                 ,&
    &                  iTab(1)             ,&
    &                  iTab(1)             ,&
    &                  Tab(1)              ,&
    &                  Tab(strd*(Nmb-1)+1) ,&
    &                  Ref(1)              ,&
    &                  Ref(1)               )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfGetBlockF90_d___
  

  function     GmfSetBlockF90_i(unit, GmfKey, ad0, ad1, Tab, Ref) result(res)
    !> int32 (:,:) + int32(:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: Tab(:,:)
    integer(int32), intent(in)    :: Ref(  :)
    integer(int32)                :: res
    !>
    integer(int32)                :: Nmb
    real(real64)                  :: dTab(1)
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfSetBlockF90_i (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfSetBlockF90_i size(Tab)=",i0,"x",i0)',size(Tab,1),size(Tab,2)
    !print '("GmfSetBlockF90_i size(Ref)=  ",i0)',size(Ref)
    
    res=GmfSetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  Tab(1,  1) ,&
    &                  Tab(1,Nmb) ,&
    &                  dTab(1)    ,&
    &                  dTab(1)    ,&
    &                  Ref(  1)   ,&
    &                  Ref(Nmb)    )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetBlockF90_i
  
  function     GmfSetBlockF90_i_(unit, GmfKey, ad0, ad1, strd, Tab, Ref) result(res)
    !> int32 (:)   + int32(:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: strd
    integer(int32), intent(in)    :: Tab(:)
    integer(int32), intent(in)    :: Ref(:)
    integer(int32)                :: res
    !>
    integer(int32)                :: Nmb
    real(real64)                  :: dTab(1)
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfSetBlockF90_i_ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfSetBlockF90_i_ strd size(Tab)/strd=",i0,"x",i0)',strd,size(Tab)/strd
    !print '("GmfSetBlockF90_i_ size(Ref)=  ",i0)',size(Ref)
    
    res=GmfSetBlockF77(unit                ,&
    &                  GmfKey              ,&
    &                  ad0                 ,&
    &                  ad1                 ,&
    &                  int32               ,&
    &                  map                 ,&
    &                  Tab(1             ) ,&
    &                  Tab(strd*(Nmb-1)+1) ,&
    &                  dTab(1)             ,&
    &                  dTab(1)             ,&
    &                  Ref(1  )            ,&
    &                  Ref(Nmb)             )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetBlockF90_i_
  
  function     GmfSetBlockF90_i__(unit, GmfKey, ad0, ad1, Tab) result(res)
    !> int32 (:,:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: Tab(:,:)
    integer(int32)                :: res
    !>
    integer(int32)                :: Ref(1)
    real(real64)                  :: dTab(1,1)
    integer(int32)                :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfSetBlockF90_i__ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfSetBlockF90_i__ size(Tab)=",i0,"x",i0)',size(Tab,1),size(Tab,2)
    
    res=GmfSetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  Tab(1,  1) ,&
    &                  Tab(1,Nmb) ,&
    &                  dTab(1,1)  ,&
    &                  dTab(1,1)  ,&
    &                  Ref(1)     ,&
    &                  Ref(1)      )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetBlockF90_i__
  
  function     GmfSetBlockF90_i___(unit, GmfKey, ad0, ad1, strd, Tab) result(res)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: strd
    integer(int32), intent(in)    :: Tab(:)
    integer(int32)                :: res
    !>
    integer(int32)                :: Ref(1)
    real(real64)                  :: dTab(1)
    integer(int32)                :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfSetBlockF90_i___ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfSetBlockF90_i___ strd size(Tab)=",i0,"x",i0)',strd,size(Tab)
    
    res=GmfSetBlockF77(unit                ,&
    &                  GmfKey              ,&
    &                  ad0                 ,&
    &                  ad1                 ,&
    &                  int32               ,&
    &                  map                 ,&
    &                  Tab(1             ) ,&
    &                  Tab(strd*(Nmb-1)+1) ,&
    &                  dTab(1)             ,&
    &                  dTab(1)             ,&
    &                  Ref(1)              ,&
    &                  Ref(1)               )        
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetBlockF90_i___
  
  function     GmfSetBlockF90_d(unit, GmfKey, ad0, ad1, Tab, Ref) result(res)
    !> real64(:,:) + int32(:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    real(real64)  , intent(in)    :: Tab(:,:)
    integer(int32), intent(in)    :: Ref(  :)
    integer(int32)                :: res
    !>
    integer(int32)                :: iTab(1)
    integer(int32)                :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfSetBlockF90_d (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfSetBlockF90_d size(Tab)=",i0,"x",i0)',size(Tab,1),size(Tab,2)
    !print '("GmfSetBlockF90_d size(Ref)=  ",i0)',size(Ref)
    
    res=GmfSetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  iTab(1)    ,&
    &                  iTab(1)    ,&
    &                  Tab(1,  1) ,&
    &                  Tab(1,Nmb) ,&
    &                  Ref(  1)   ,&
    &                  Ref(Nmb)    )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetBlockF90_d
  
  function     GmfSetBlockF90_d_(unit, GmfKey, ad0, ad1, strd, Tab, Ref) result(res)
    !> real64(:)   + int32(:)
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: strd
    real(real64)  , intent(in)    :: Tab(:)
    integer(int32), intent(in)    :: Ref(:)
    integer(int32)                :: res
    !>
    integer(int32)                :: iTab(1)
    integer(int32)                :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfSetBlockF90_d_ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfSetBlockF90_d_ strd,size(Tab)/strd=",i0,"x",i0)',strd,size(Tab)/strd
    !print '("GmfSetBlockF90_d_ size(Ref)=  ",i0)',size(Ref)
    
    res=GmfSetBlockF77(unit               ,&
    &                  GmfKey             ,&
    &                  ad0                ,&
    &                  ad1                ,&
    &                  int32              ,&
    &                  map                ,&
    &                  iTab(1)            ,&
    &                  iTab(1)            ,&
    &                  Tab(             1),&
    &                  Tab(strd*(Nmb-1)+1),&
    &                  Ref(1  )           ,&
    &                  Ref(Nmb)            )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetBlockF90_d_
  
  function     GmfSetBlockF90_d__(unit, GmfKey, ad0, ad1, Tab) result(res)
    !> real64(:,:)       
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)           :: unit
    integer(int32), intent(in)           :: GmfKey
    integer(int32), intent(in)           :: ad0
    integer(int32), intent(in)           :: ad1
    real(real64)  , intent(in)           :: Tab(:,:)
    integer(int32)                       :: res
    !>
    integer(int32)                       :: Ref(1)
    integer(int32)                       :: iTab(1)
    integer(int32)                       :: Nmb
    integer(int32), pointer              :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfSetBlockF90_d__ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfSetBlockF90_d__ size(Tab)=",i0,"x",i0)',size(Tab,1),size(Tab,2)
    
    res=GmfSetBlockF77(unit       ,&
    &                  GmfKey     ,&
    &                  ad0        ,&
    &                  ad1        ,&
    &                  int32      ,&
    &                  map        ,&
    &                  iTab(1)    ,&
    &                  iTab(1)    ,&
    &                  Tab(1,  1) ,&
    &                  Tab(1,Nmb) ,&
    &                  Ref(1)     ,&
    &                  Ref(1)      )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetBlockF90_d__
  
  function     GmfSetBlockF90_d___(unit, GmfKey, ad0, ad1, strd, Tab) result(res)
    !> real64(:)  
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    integer(int64), intent(in)    :: unit
    integer(int32), intent(in)    :: GmfKey
    integer(int32), intent(in)    :: ad0
    integer(int32), intent(in)    :: ad1
    integer(int32), intent(in)    :: strd
    real(real64)  , intent(inout) :: Tab(:)
    integer(int32)                :: res
    !>
    integer(int32)                :: Ref(1)
    integer(int32)                :: iTab(1)
    integer(int32)                :: Nmb
    integer(int32), pointer       :: map(:)=>null()
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    !>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    Nmb=ad1-ad0+1
    
    !print '("GmfSetBlockF90_d___ (ad0,ad1)=(",i0,",",i0,") Nmb=",i0)',ad0,ad1,Nmb
    !print '("GmfSetBlockF90_d___ strd x size(Tab)=",i0,"x",i0)',strd,size(Tab)/strd
    
    res=GmfSetBlockF77(unit                ,&
    &                  GmfKey              ,&
    &                  ad0                 ,&
    &                  ad1                 ,&
    &                  int32               ,&
    &                  map                 ,&
    &                  iTab(1)             ,&
    &                  iTab(1)             ,&
    &                  Tab(1             ) ,&
    &                  Tab(strd*(Nmb-1)+1) ,&
    &                  Ref(1)              ,&
    &                  Ref(1)               )
    !<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
    return
  end function GmfSetBlockF90_d___
  
end module libmeshb7