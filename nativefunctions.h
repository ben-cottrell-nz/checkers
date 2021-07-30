#ifndef NATIVEFUNCTIONS_H
#define NATIVEFUNCTIONS_H

#include <QObject>
#include <QPoint>

class NativeFunctions : public QObject
{
    Q_OBJECT
public:
    explicit NativeFunctions(QObject *parent = nullptr);
    Q_INVOKABLE QPoint globalMousePos();

};

#endif // NATIVEFUNCTIONS_H
