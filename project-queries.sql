-- Stock functions I use for viewing and management

-- All tested on database

-- Select all tables
SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public'; 

-- Check if Events table exist
SELECT * FROM Events LIMIT 1;
-- Check if EventInstance table exist
SELECT * FROM EventInstance LIMIT 1;

-- View all stored functions I created
SELECT routine_name
FROM information_schema.routines
WHERE routine_type = 'FUNCTION'
AND specific_schema = 'public';

-- Generate functions to drop all functions. Sometimes REPLACE doesn't work cleanly
SELECT 'DROP FUNCTION ' || ns.nspname || '.' || proname 
       || '(' || oidvectortypes(proargtypes) || ');'
FROM pg_proc INNER JOIN pg_namespace ns ON (pg_proc.pronamespace = ns.oid)
WHERE ns.nspname = 'public'  order by proname;

-- Current drop functions funcitons generated by previous statement
DROP FUNCTION public.create_event(character varying, text, text, date, date, time without time zone, time without time zone, integer, integer);
DROP FUNCTION public.create_event_instances(date, date);
DROP FUNCTION public.delete_event(integer);
DROP FUNCTION public.edit_event(integer, character varying, text, text, date, date, time without time zone, time without time zone, integer, integer);
DROP FUNCTION public.insert_event_instance(integer, timestamp without time zone, timestamp without time zone);
DROP FUNCTION public.update_display(date, date);

-- Test simple insert
SELECT create_event('Dummy', 'Dumdum', 'dummm', 
                    '2024-03-05', NULL, '12:00:00', '16:00:00', 0, 0); 

-- Test complex insert
SELECT create_event('March 7th!', 'This is a video game reference', 'Astral Express', 
                    '2024-03-07', NULL, '11:00:00', '16:00:00', 6, 0307); 
-- Note that 0307 is stored as 307, but that does not affect the correctness of int parsing.

-- View the event
SELECT * from Events;

-- View the specific events

SELECT * FROM Events
WHERE Events.StartDate >= '2024-03-05' AND
(Events.EndDate IS NULL OR Events.EndDate <= '2024-03-12') 

-- Update display

SELECT update_display('2024-01-06'::DATE, '2025-06-08'::DATE);

-- View EventInstances after updating display

SELECT * FROM EventInstance;

DROP FUNCTION public.create_event(character varying, text, text, date, date, time without time zone, time without time zone, integer, integer);
DROP FUNCTION public.create_event_instances(date, date);
DROP FUNCTION public.delete_event(integer);
DROP FUNCTION public.edit_event(integer, character varying, text, text, date, date, time without time zone, time without time zone, integer, integer);
DROP FUNCTION public.insert_event_instance(integer, timestamp without time zone, timestamp without time zone);
DROP FUNCTION public.update_display(date, date);