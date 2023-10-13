BUILD_DIR="./../../builds/RV64ACDFIMSUxCHERI_Toooba_bluesim/build_dir"
bsc -bdir $BUILD_DIR -simdir $BUILD_DIR ./../../src_Core/RISCY_OOO/coherence/src/Prefetcher.bsv && \
bsc -bdir $BUILD_DIR -show-range-conflict -simdir $BUILD_DIR -sim -g mkSimpleStridePCPrefetcherTest ./../../src_Testbench/Unit/Prefetcher_test.bsv && bsc -bdir $BUILD_DIR -simdir $BUILD_DIR -sim -e mkSimpleStridePCPrefetcherTest -o prefetch_simplestridepc_test &&  \
./prefetch_simplestridepc_test && \
rm ./prefetch_simplestridepc_test*
