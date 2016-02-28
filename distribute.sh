#! /bin/bash

FILENAME_M='RCKViewHierarchyCodeGenerator.m'
FILENAME_H='RCKViewHierarchyCodeGenerator.h'

SOURCES_DIR='Classes/Generator'
SOURCES_M=(
'RCKUtilities.h'
'RCKViewItem.h'
'RCKViewItem.m'
'RCKConstraintItem.h'
'RCKConstraintItem.m'
'RCKConstraintsGenerator.h'
'RCKUIKitConstraintsGenerator.h'
'RCKUIKitConstraintsGenerator.m'
'RCKMasonryConstraintsGenerator.h'
'RCKMasonryConstraintsGenerator.m'
'RCKViewHierarchyCodeGenerator.m'
)

SOURCES_H=(
'RCKViewHierarchyCodeGenerator.h'
)

TEMP_DIR='tmp'

mkdir $TEMP_DIR

echo 'Copy sources...'

for f in ${SOURCES_M[@]}
do
cp $SOURCES_DIR/$f $TEMP_DIR/.
done

for f in ${SOURCES_H[@]}
do
cp $SOURCES_DIR/$f $TEMP_DIR/.
done

echo 'Cleanup...'

for f in ${SOURCES_M[@]}
do
sed -i '' -e '/\/\//d' -e '/#/d' $TEMP_DIR/$f
done

for f in ${SOURCES_H[@]}
do
sed -i '' -e '/\/\//d' -e '/#/d' $TEMP_DIR/$f
done

echo 'Generate...'

echo -e '//' > $FILENAME_M
echo -e '//  '$FILENAME_M >> $FILENAME_M
echo -e '//  iOS-View-Hierarchy-Code-Generator' >> $FILENAME_M
echo -e '//' >> $FILENAME_M
echo -e '//  Created by rock88, file generated at '`date -u` >> $FILENAME_M
echo -e '//  Copyright © 2016 rock88. All rights reserved.' >> $FILENAME_M
echo -e '//' >> $FILENAME_M
echo -e '' >> $FILENAME_M
echo -e '#import <UIKit/UIKit.h>' >> $FILENAME_M
echo -e '#import "'$FILENAME_H'"' >> $FILENAME_M

for f in ${SOURCES_M[@]}
do
for groupline in "$(cat $TEMP_DIR/$f)"
do
echo "$groupline" >> $FILENAME_M
done
done

echo -e '//' > $FILENAME_H
echo -e '//  '$FILENAME_H >> $FILENAME_H
echo -e '//  iOS-View-Hierarchy-Code-Generator' >> $FILENAME_H
echo -e '//' >> $FILENAME_H
echo -e '//  Created by rock88, file generated at '`date -u` >> $FILENAME_H
echo -e '//  Copyright © 2016 rock88. All rights reserved.' >> $FILENAME_H
echo -e '//' >> $FILENAME_H
echo -e '' >> $FILENAME_H
echo -e '#import <Foundation/Foundation.h>' >> $FILENAME_H

for f in ${SOURCES_H[@]}
do
for groupline in "$(cat $TEMP_DIR/$f)"
do
echo "$groupline" >> $FILENAME_H
done
done

rm -fr $TEMP_DIR

echo 'Done'
