

//创建static
//查看.a文件的信息： lipo -info xxx.a
//合并两个.a文件：lipo -create xxx.a xxxx.a -output test.a

//找不到方法的时候，是因为l没有链接进来
//解决：链接OC文件 -ObjC
//     链接所有文件 -all_load
//     链接指定文件 -force_load path


//创建framework
//Build Phases里面添加Copy Files，否则会报image not found的错误
//合并动态库的运行脚本
//if [ "${ACTION}" = "build" ]
//then
//INSTALL_DIR=${SRCROOT}/Products/${PROJECT_NAME}.framework
//DEVICE_DIR=${BUILD_ROOT}/${CONFIGURATION}-iphoneos/${PROJECT_NAME}.framework
//SIMULATOR_DIR=${BUILD_ROOT}/${CONFIGURATION}-iphonesimulator/${PROJECT_NAME}.framework
//
//if [ -d "${INSTALL_DIR}" ]
//then
//rm -rf "${INSTALL_DIR}"
//fi
//
//mkdir -p "${INSTALL_DIR}"
//
//cp -R "${DEVICE_DIR}/" "${INSTALL_DIR}/"
//#ditto "${DEVICE_DIR}/Headers" "${INSTALL_DIR}/Headers"
//
//lipo -create "${DEVICE_DIR}/${PROJECT_NAME}" "${SIMULATOR_DIR}/${PROJECT_NAME}" -output "${INSTALL_DIR}/${PROJECT_NAME}"
//
//#open "${DEVICE_DIR}"
//#open "${SRCROOT}/Products"
//fi
