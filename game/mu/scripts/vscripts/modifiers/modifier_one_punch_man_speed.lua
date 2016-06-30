--объявляем наш модификатор как объект-класс
modifier_one_punch_man_speed = class({})

--возвращаем false (лож) на вопросы о скрывании модификатора с глаз
--мы ведь хотим видеть красивую иконочку над показателями здоровья
function modifier_one_punch_man_speed:IsHidden()
	return false
end

--эта штука будет на любые распросы о типе нашего модификатора
--говорить, что он на скорость атаки
--все типы можете в офф документации глянуть
function modifier_one_punch_man_speed:DeclareFunctions()
	return { MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT  }
end

--тут возвращаем имя иконочки
--не буду рассказывать, как делать иконочку
--можете использовать тут имена стандартных абилок
--например вместо моего "one_punch_man" взять "brewmaster_drunken_haze"
function modifier_one_punch_man_speed:GetTexture()
    return "one_punch_man"
end

--когда нас спросят, а сколько скорости то плюсануть
--мы ответим 99999
function modifier_one_punch_man_speed:GetModifierAttackSpeedBonus_Constant()
		return 99999
end

--возвращаем true на любые вопросы о том
--удалять ли модификатор, если носитель умрет
--можете и false поставить, чтобы он не пропадал после смерти
--как хотите
function modifier_one_punch_man_speed:RemoveOnDeath()
	return true
end