package org.infocentre.talend.log4j;
// Import log4j classes.
import org.apache.log4j.Logger;
// import org.apache.log4j.BasicConfigurator;
// import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.xml.DOMConfigurator;
import java.util.Hashtable;
import org.apache.log4j.MDC;
import org.apache.log4j.NDC;

public class TalendLog4JConfigurator {

	// Define a static logger variable so that it references the
	// Logger instance named "TalendLog4JConfigurator".
	static Logger logger = Logger.getLogger(TalendLog4JConfigurator.class);

	public static void configureLog4J(String filename, Boolean isLocked, String nomHost, String nomContexte, String ArtifactId, String Version, String logIdentification, String ndc_message) {
		try
		{
			MDC.put("nomHost", nomHost);
			MDC.put("nomContexte", nomContexte);
			MDC.put("ArtifactId", ArtifactId);
			MDC.put("Version", Version);
			MDC.put("logIdentification", logIdentification);
			NDC.push(ndc_message);

			DOMConfigurator.configure(filename);
			logger.info("Entering application.");
			logger.info("filename:"+filename);
			logger.info("isLocked:"+isLocked);
			logger.info("nomHost:"+nomHost);
			logger.info("nomContexte:"+nomContexte);
			logger.info("ArtifactId:"+ArtifactId);
			logger.info("Version:"+Version);
			logger.info("logIdentification:"+logIdentification);
			logger.info("ndcMessage:"+ndc_message);
			logger.info("Exiting application.");
		}
		catch(Exception e)
		{
			logger.info("erreur catchee.");
		}
	}
}
