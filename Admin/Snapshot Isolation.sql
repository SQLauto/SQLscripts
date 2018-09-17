select name
        , s.snapshot_isolation_state
        , snapshot_isolation_state_desc
        , is_read_committed_snapshot_on
        , recovery_model
        , recovery_model_desc
        , collation_name
    from sys.databases s
	where snapshot_isolation_state_desc = 'ON'
	and is_read_committed_snapshot_on = '1'