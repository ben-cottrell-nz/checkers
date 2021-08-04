#include "nativefunctions.h"
#include <QCursor>
#include <QMouseEvent>

NativeFunctions::NativeFunctions(QObject *parent) : QObject(parent)
{

}

QPoint NativeFunctions::globalMousePos()
{
    //On Android this returns 0xFFFFFFFF
    return QCursor::pos();
}
