#include "nativefunctions.h"
#include <QCursor>

NativeFunctions::NativeFunctions(QObject *parent) : QObject(parent)
{

}

QPoint NativeFunctions::globalMousePos()
{
    return QCursor::pos();
}
