#############################################################
#
# Generate a repository for opkg
#
#############################################################

define ROOTFS_IPK_REPO_CMD
 mkdir -p $(BINARIES_DIR)/ipk_repository;                                                             \
 ( cd $(BINARIES_DIR)/ipk_repository && dpkg-scanpackages . ) > $(BINARIES_DIR)/ipk_repository/Packages; \
 gzip < $(BINARIES_DIR)/ipk_repository/Packages      > $(BINARIES_DIR)/ipk_repository/Packages.gz;    \
 echo "Archive: unstable"                           >> $(BINARIES_DIR)/ipk_repository/Release;        \
 echo "Origin: Buildroot"                           >> $(BINARIES_DIR)/ipk_repository/Release;        \
 echo "Label: Buildroot autogenerated repository"   >> $(BINARIES_DIR)/ipk_repository/Release;        \
 echo "Architecture: $(ARCH)"                       >> $(BINARIES_DIR)/ipk_repository/Release;        \
 echo "Your repository is ready.";                                                                    \
 echo "If you use opkg, add this line to your /etc/opkg/buildroot.conf:";                             \
 echo "   src/gz buildroot file://$(BINARIES_DIR)/ipk_repository";                                    \
 echo "If you use apt, add this one to /etc/apt/sources.list.d/buildroot.list:";                      \
 echo "   deb file://$(BINARIES_DIR)/ipk_repository .";
endef

$(eval $(call ROOTFS_TARGET,ipk_repo)) 