SELECT t.fiscalyear, t.postdatebegin, t.divisionid, t.clinician, t.nj_ip_or_day_rvus AS adu_rvus,
t.hospital_rvus + t.icu_day_rvus + t.icu_night_rvus AS cc_hospital_rvus,
t.clinic_rvus + t.psych_rvus + t.neuro_rvus AS clinic_rvus,
t.ppu_rvus + t.sleep_rvus + t.cardiology_rvus + t.radiology_rvus + t.ph_probe_rvus + t.belpt_rvus + t.other_rvus AS interp_other_rvus
FROM
	(SELECT yb.fiscalyear, yb.postdatebegin, yb.divisionid, yb.clinician,
		CASE
			WHEN cc.clinic='X' THEN yb.totalrvu
			ELSE 0
		END
			AS clinic_rvus,
		CASE
			WHEN cc.nj_ip_or_day='X' THEN yb.totalrvu
			ELSE 0
		END
			AS nj_ip_or_day_rvus,
		CASE
			WHEN cc.hospital='X' THEN yb.totalrvu
			ELSE 0
		END
			AS hospital_rvus,
		CASE
			WHEN cc.icu_day='X' THEN yb.totalrvu
			ELSE 0
		END
			AS icu_day_rvus,
		CASE
			WHEN cc.icu_night='X' THEN yb.totalrvu
			ELSE 0
		END
			AS icu_night_rvus,
		CASE
			WHEN cc.psych='X' THEN yb.totalrvu
			ELSE 0
		END
			AS psych_rvus,
		CASE
			WHEN cc.neuro_tech='X' THEN yb.totalrvu
			ELSE 0
		END
			AS neuro_rvus,
		CASE
			WHEN cc.ppu='X' THEN yb.totalrvu
			ELSE 0
		END
			AS ppu_rvus,
		CASE
			WHEN cc.sleep='X' THEN yb.totalrvu
			ELSE 0
		END
			AS sleep_rvus,
		CASE
			WHEN cc.cardiology='X' THEN yb.totalrvu
			ELSE 0
		END
			AS cardiology_rvus,
		CASE
			WHEN cc.radiology='X' THEN yb.totalrvu
			ELSE 0
		END
			AS radiology_rvus,
		CASE
			WHEN cc.ph_probe='X' THEN yb.totalrvu
			ELSE 0
		END
			AS ph_probe_rvus,
		CASE
			WHEN cc.belpt='X' THEN yb.totalrvu
			ELSE 0
		END
			AS belpt_rvus,
		CASE
			WHEN cc.other='X' THEN yb.totalrvu
			ELSE 0
		END
			AS other_rvus
	FROM ytd_billings yb
		JOIN charge_codes cc ON yb.chargecode = cc.charge_code) AS t
ORDER BY t.divisionid, t.clinician, t.postdatebegin;