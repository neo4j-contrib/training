public class SimpleDurationParser
{







    public static double parseTextToMillis( String duration )
    {
        String[] fields = duration.split( "[^-+\\d\\.]" );
        double value = Double.parseDouble( fields[0] );
        String units = duration.substring( fields[0].length() ).toLowerCase();
        if ( units.startsWith( "ms" ) )
        {
            return value;
        }
        else if ( units.startsWith( "milli" ) )
        {
            return value;
        }
        else if ( units.startsWith( "s" ) )
        {
            return value * 1000.0;
        }
        else if ( units.startsWith( "m" ) )
        {
            return value * 1000.0 * 60.0;
        }
        else if ( units.startsWith( "h" ) )
        {
            return value * 1000.0 * 60.0 * 60.0;
        }
        else if ( units.startsWith( "d" ) )
        {
            return value * 1000.0 * 60.0 * 60.0 * 24.0;
        }
        else
        {
            throw new IllegalArgumentException(
                    "Unknown units specified in '" + duration + "' - supported units are: (ms, s, m, h, d)" );
        }
    }
}
