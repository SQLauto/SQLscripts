

select * from openquery(ls_EP1 ,'select 
vbak.VBELN as ord_id
, vbap.POSNR as ord_line
,vbak.AUART as ord_type
, vbak.AUDAT as ord_dt
, likp.WADAT_IST as ship_date
, z.CONFIG_STATUS
, z.VBELN
, z.POSNR
, z.BWART
,(CASE WHEN z.CONFIG_STATUS = ''O'' THEN ''IsOptimal'' 
WHEN z.CONFIG_STATUS = ''C'' THEN ''IsCritical''
WHEN z.CONFIG_STATUS = ''M'' THEN ''IsMinimal'' 
ELSE ''NULL'' END) as OrderShippedAs,
(CASE WHEN likp.WADAT_IST <= vbak.AUDAT THEN 1 ELSE 0 END)  as OnTimeCount,
(CASE WHEN likp.WADAT_IST > vbak.AUDAT THEN 1 ELSE 0 END)  as LateCount,
(CASE WHEN (likp.WADAT_IST is null or likp.WADAT_IST ='''')  THEN 1 ELSE 0 END)  as OpenRejectedCount,
(CASE WHEN z.CONFIG_STATUS = ''O'' THEN 1 ELSE 0 END) as IsOptimalCount,
(CASE WHEN z.CONFIG_STATUS = ''C'' THEN 1 
ELSE 0 END) as IsCriticalCount,
(CASE WHEN z.CONFIG_STATUS = ''M'' THEN 1 
ELSE 0 END) as IsMinimalCount
from EP1.ep1.VBAK vbak
inner  join EP1.ep1.VBAP vbap
on vbap.VBELN = vbak.VBELN
left  outer join EP1.ep1.LIPS lips
on lips.VGBEL = vbak.VBELN
and lips.VGPOS = vbap.POSNR
and lips.POSNR not like ''900%''
left outer join EP1.ep1.LIKP likp
on lips.VBELN = likp.VBELN
  left outer join EP1.ep1.ZSETHISTORY z
  on vbap.VBELN = z.VBELN_VL 
and vbap.POSNR = z.POSNR_VL 
and z.PROCESS_STATUS = ''00''
and z.BWART in (''Y07'',''Y04'')
where vbak.AUDAT between ''20150530'' and ''20150606''
--and vbak.VBELN = ''0000732554'' 
and vbak.AUART <> ''ZSRG''')



DECLARE @variable nVARCHAR(10)
DECLARE @sqlQuery nVARCHAR(max)
DECLARE @finalQuery nVARCHAR(max)


set @sqlQuery = ('select 
vbak.VBELN as ord_id
, vbap.POSNR as ord_line
,vbak.AUART as ord_type
, vbak.AUDAT as ord_dt
, likp.WADAT_IST as ship_date
, z.CONFIG_STATUS
, z.VBELN
, z.POSNR
, z.BWART
,(CASE WHEN z.CONFIG_STATUS = ''O'' THEN ''IsOptimal'' 
WHEN z.CONFIG_STATUS = ''C'' THEN ''IsCritical''
WHEN z.CONFIG_STATUS = ''M'' THEN ''IsMinimal'' 
ELSE ''NULL'' END) as OrderShippedAs,
(CASE WHEN likp.WADAT_IST <= vbak.AUDAT THEN 1 ELSE 0 END)  as OnTimeCount,
(CASE WHEN likp.WADAT_IST > vbak.AUDAT THEN 1 ELSE 0 END)  as LateCount,
(CASE WHEN (likp.WADAT_IST is null or likp.WADAT_IST ='''')  THEN 1 ELSE 0 END)  as OpenRejectedCount,
(CASE WHEN z.CONFIG_STATUS = ''O'' THEN 1 ELSE 0 END) as IsOptimalCount,
(CASE WHEN z.CONFIG_STATUS = ''C'' THEN 1 
ELSE 0 END) as IsCriticalCount,
(CASE WHEN z.CONFIG_STATUS = ''M'' THEN 1 
ELSE 0 END) as IsMinimalCount
from EP1.ep1.VBAK vbak
inner  join EP1.ep1.VBAP vbap
on vbap.VBELN = vbak.VBELN
left  outer join EP1.ep1.LIPS lips
on lips.VGBEL = vbak.VBELN
and lips.VGPOS = vbap.POSNR
and lips.POSNR not like ''900%''
left outer join EP1.ep1.LIKP likp
on lips.VBELN = likp.VBELN
  left outer join EP1.ep1.ZSETHISTORY z
  on vbap.VBELN = z.VBELN_VL 
and vbap.POSNR = z.POSNR_VL 
and z.PROCESS_STATUS = ''00''
and z.BWART in (''Y07'',''Y04'')
where vbak.AUDAT between ''20150530'' and ''20150606''
--and vbak.VBELN = ''0000732554'' 
and vbak.AUART <> ''ZSRG''')



--used for debugging
print (@sqlQuery )

