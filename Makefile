include ../../include.mk
binPath = ../../bin
libPath = ../../lib

libSources = impl/*.c
libHeaders = inc/*.h

all : ${libPath}/sonLib.a ${binPath}/sonLibTests

clean : 
	rm -f  ${binPath}/sonLibTests ${libPath}/sonLib*.h ${libPath}/sonLib.a ${libPath}/avl.h ${libPath}/bioioC.h ${libPath}/commonC.h ${libPath}/fastCMaths.h ${libPath}/hashTableC.h ${libPath}/pairwiseAlignment.h

${binPath}/sonLibTests : ${libSources} ${libHeaders} ${libPath}/sonLib.a ${libPath}/cuTest.a
	${cxx} ${cflags} -I inc -I ${libPath} -o ${binPath}/sonLibTests impl/allTests.c ${libPath}/sonLib.a ${libPath}/cuTest.a ${tokyoCabinetLib}

${libPath}/sonLib.a : ${libSources} ${libHeaders}
	cp ${libHeaders} ${libPath}/
	${cxx} ${cflags} -I inc -I ${libPath}/ -c ${libSources}
	ar rc sonLib.a *.o
	ranlib sonLib.a 
	rm *.o
	mv sonLib.a ${libPath}/
