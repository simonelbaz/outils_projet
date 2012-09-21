package org.infocentre.talend.log4j;
// Import log4j classes.
import org.apache.log4j.Logger;
// import org.apache.log4j.BasicConfigurator;
// import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.xml.DOMConfigurator;

public class TalendLog4JConfigurator {

	// Define a static logger variable so that it references the
	// Logger instance named "TalendLog4JConfigurator".
	static Logger logger = Logger.getLogger(TalendLog4JConfigurator.class);

	public static void configureLog4J(String filename, Boolean isLocked) {
		try
		{
			DOMConfigurator.configure(filename);
			logger.info("Entering application.");
			logger.info("filename2:"+filename);
			logger.info("isLocked2:"+isLocked);
			logger.info("Exiting application.");
		}
		catch(Exception e)
		{
			logger.info("erreur catchee.");
		}
	}
}
