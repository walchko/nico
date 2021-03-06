/******************************************************************************
 *                                                                            *
 *             Copyright (C) 2016 Mogi, LLC - All Rights Reserved             *
 *                          Author: Adrian Lizarraga                          *
 *                                                                            *
 *            This program is distributed under the LGPL, version 2           *
 *                                                                            *
 *   This program is free software; you can redistribute it and/or modify     *
 *   it under the terms of the GNU Lesser General Public License              *
 *   version 2.1 as published by the Free Software Foundation;                *
 *                                                                            *
 *   See license in root directory for terms.                                 *
 *   https://github.com/mogillc/nico/tree/master/edisonLibmogiPackage/libmogi *
 *                                                                            *
 *****************************************************************************/

/*
 * JSONParser.h
 *
 *  Created on: Oct 5, 2014
 *      Author: adrian
 */

#ifndef LOGGER_H_
#define LOGGER_H_
#include <iostream>
#include <sstream>

#if defined(ANDROID)
	#include <mogi/port/android/StringBuffer.h>
#elif defined(BUILD_FOR_IOS)
	#include <mogi/StringBuffer.h>
#else
	#include <mogi/StringBuffer.h>
#endif

namespace Mogi {
	
	/*! \class Logger
	 \brief Singleton logging class for cross-platform output logging. 
	 */
	class Logger : public std::ostream {
	public:
		/**
		 * Returns a singleton Logger instance.
		 */
		static Logger& getInstance() {
#if defined(ANDROID)
			static Logger instance(new Android::StringBuffer()); // Guaranteed to be destroyed.
	                                      // Instantiated on first use.
#elif defined(BUILD_FOR_IOS)
			static Logger instance(new StringBuffer()); // Guaranteed to be destroyed.
	                                      // Instantiated on first use.
#else
			static Logger instance(new StringBuffer()); // Guaranteed to be destroyed.
	                                      // Instantiated on first use.
#endif


			return instance;
		}			
	private:
		// Private constructors and assignment operator
		Logger(std::stringbuf* pBuf) : std::ostream(pBuf) {
			
		}

		~Logger() {
			delete rdbuf();
		}

		Logger(const Logger&);
		Logger& operator=(const Logger&);
	};
	
} /* namespace Mogi */

#endif /* LOGGER_H_ */
